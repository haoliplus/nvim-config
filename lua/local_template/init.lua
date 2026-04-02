local M = {
  author = "",
  email = "",
  temp_dir = nil,
}

local cursor_pattern = "{{_cursor_}}"

local function normalize(path)
  return vim.fs.normalize(path)
end

local function read_first_line(path)
  local lines = vim.fn.readfile(path, "", 1)
  return lines[1]
end

local function split_ext(filename)
  local tail = vim.fn.fnamemodify(filename, ":t")
  local root = vim.fn.fnamemodify(filename, ":t:r")
  return tail, root
end

local function camel_case(value)
  local parts = vim.split(value, "_", { trimempty = true })
  for index, part in ipairs(parts) do
    parts[index] = part:sub(1, 1):upper() .. part:sub(2)
  end
  return table.concat(parts)
end

local function template_filetype(path)
  local ft = vim.filetype.match({ filename = path })
  if ft == "smarty" then
    local first = read_first_line(path)
    if first then
      local parts = vim.split(first, "%s+", { trimempty = true })
      if parts[1] == ";;" then
        return parts[2]
      end
    end
  end
  return ft
end

function M.get_temp_list()
  if not M.temp_dir or M.temp_dir == "" then
    return {}
  end

  local temp_dir = normalize(M.temp_dir)
  local files = vim.fs.find(function(name)
    return name:match(".*")
  end, { path = temp_dir, type = "file", limit = math.huge })
  local links = vim.fs.find(function(name)
    return name:match(".*")
  end, { path = temp_dir, type = "link", limit = math.huge })
  local result = {}

  for _, path in ipairs(vim.list_extend(files, links)) do
    local ft = template_filetype(path)
    if ft then
      result[ft] = result[ft] or {}
      table.insert(result[ft], path)
    else
      vim.notify("[local_template] Could not determine filetype for " .. path, vim.log.levels.INFO)
    end
  end

  for _, items in pairs(result) do
    table.sort(items)
  end

  return result
end

local function build_context(opts)
  local filename = opts.filename or vim.api.nvim_buf_get_name(0)
  local tail, root = split_ext(filename)
  return {
    filename = filename,
    file_tail = tail,
    file_root = root,
    variables = opts.variables or {},
  }
end

local function resolve_token(token, context)
  if token == "cursor" then
    return ""
  end
  if token == "date" then
    return os.date("%Y-%m-%d %H:%M:%S")
  end
  if token == "tomorrow" then
    local date = os.date("*t")
    date.day = date.day + 1
    return os.date("%c", os.time(date))
  end
  if token == "author" or token == "name" then
    return M.author
  end
  if token == "email" then
    return M.email
  end
  if token == "file_name" then
    return context.file_root
  end
  if token == "file" then
    return context.file_tail
  end
  if token == "upper_file" then
    return context.file_root:upper()
  end
  if token == "camel_file" or token == "camel_case_file" then
    return camel_case(context.file_root)
  end
  if token == "variable" then
    return context.variables.variable or vim.fn.input("Variable name: ", "")
  end
  if vim.startswith(token, "lua:") then
    local chunk, err = load("return " .. token:sub(5))
    if not chunk then
      vim.notify("[local_template] Lua template error: " .. err, vim.log.levels.ERROR)
      return ""
    end
    local ok, value = pcall(chunk)
    if not ok then
      vim.notify("[local_template] Lua template error: " .. value, vim.log.levels.ERROR)
      return ""
    end
    return value == nil and "" or tostring(value)
  end
  return "{{_" .. token .. "_}}"
end

function M.render_template(path, opts)
  opts = opts or {}
  local context = build_context(opts)
  local lines = vim.fn.readfile(path)
  local rendered = {}
  local cursor

  for index, line in ipairs(lines) do
    if index == 1 and vim.startswith(line, ";; ") then
      goto continue
    end

    local current = line
    local cursor_start, cursor_end = current:find(cursor_pattern, 1, true)
    if cursor_start then
      cursor = { #rendered + 1, cursor_start }
    end

    current = current:gsub("{{_(.-)_}}", function(token)
      return resolve_token(token, context)
    end)
    table.insert(rendered, current)

    ::continue::
  end

  return rendered, cursor
end

function M.template_candidates(filetype)
  local list = M.get_temp_list()
  local templates = list[filetype] or {}
  return vim.tbl_map(function(path)
    return vim.fn.fnamemodify(path, ":t:r")
  end, templates)
end

function M.find_template_path(filetype, name)
  local list = M.get_temp_list()
  for _, path in ipairs(list[filetype] or {}) do
    if vim.fn.fnamemodify(path, ":t:r") == name then
      return path
    end
  end
end

local function ensure_file_loaded(filename)
  if not filename then
    return
  end
  local path = normalize(vim.fn.getcwd() .. "/" .. filename)
  if vim.fn.filereadable(path) == 0 then
    local fd = assert(vim.uv.fs_open(path, "w", 420))
    vim.uv.fs_close(fd)
  end
  vim.cmd.edit(vim.fn.fnameescape(path))
end

local function parse_args(args)
  local data = {}
  for _, value in ipairs(args) do
    if value:find("%.%w+$") then
      data.file = value
    else
      data.template = value
    end
  end
  return data
end

function M.apply_template(path, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local lines, cursor = M.render_template(path, { filename = filename })
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local start = current_line
  if current_line == 1 and #vim.api.nvim_get_current_line() == 0 then
    start = 0
  end

  vim.api.nvim_buf_set_lines(bufnr, start, current_line, false, lines)
  if cursor then
    local row = start == 0 and cursor[1] or current_line + cursor[1]
    vim.api.nvim_win_set_cursor(0, { row, cursor[2] - 1 })
    vim.cmd("startinsert!")
  end
end

function M.generate_template(args)
  local parsed = parse_args(args)
  if parsed.file then
    ensure_file_loaded(parsed.file)
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype
  local template_name = parsed.template
  if not template_name then
    template_name = "default"
  end

  local path = M.find_template_path(filetype, template_name)
  if not path then
    vim.notify(string.format("[local_template] No template named %q for filetype %q", template_name, filetype), vim.log.levels.WARN)
    return
  end

  M.apply_template(path, bufnr)
end

local function command_complete(arglead, cmdline)
  local args = vim.split(cmdline, "%s+", { trimempty = true })
  local filetype = vim.bo.filetype
  if #args >= 2 and args[2]:find("%.%w+$") then
    filetype = vim.filetype.match({ filename = args[2] }) or filetype
  end

  local candidates = M.template_candidates(filetype)
  if arglead == "" then
    return candidates
  end

  return vim.tbl_filter(function(item)
    return vim.startswith(item, arglead)
  end, candidates)
end

function M.setup(opts)
  vim.validate("opts", opts, "table")
  vim.validate("opts.temp_dir", opts.temp_dir, "string")
  vim.validate("opts.author", opts.author, "string", true)
  vim.validate("opts.email", opts.email, "string", true)

  M.temp_dir = opts.temp_dir
  M.author = opts.author or ""
  M.email = opts.email or ""

  if vim.fn.exists(":Template") ~= 2 then
    vim.api.nvim_create_user_command("Template", function(command)
      M.generate_template(command.fargs)
    end, {
      nargs = "+",
      complete = command_complete,
    })
  end
end

return M
