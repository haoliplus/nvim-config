local function eq(actual, expected, message)
  if actual ~= expected then
    error((message or "assertion failed") .. string.format("\nexpected: %s\nactual: %s", vim.inspect(expected), vim.inspect(actual)))
  end
end

local function truthy(value, message)
  if not value then
    error(message or "expected value to be truthy")
  end
end

local function starts_with(actual, prefix, message)
  if not vim.startswith(actual, prefix) then
    error((message or "assertion failed") .. string.format("\nexpected prefix: %s\nactual: %s", vim.inspect(prefix), vim.inspect(actual)))
  end
end

local module = require("local_template")

local workspace = vim.fn.tempname()
vim.fn.mkdir(workspace, "p")
local templates_dir = workspace .. "/templates"
vim.fn.mkdir(templates_dir, "p")

local py_template = {
  "# {{_author_}} <{{_email_}}>",
  "year={{_lua:os.getenv(\"LICENSE\")_}}",
  "name={{_file_name_}}",
  "cursor={{_cursor_}}",
}
vim.fn.writefile(py_template, templates_dir .. "/default.py")

module.setup({
  temp_dir = templates_dir,
  author = "Li Hao",
  email = "lihao@example.com",
})

local temp_list = module.get_temp_list()
truthy(temp_list.python, "python templates should be discovered")
eq(vim.fn.fnamemodify(temp_list.python[1], ":t"), "default.py", "template file should be indexed")

local rendered, cursor = module.render_template(temp_list.python[1], {
  filename = "/tmp/sample.py",
})

eq(rendered[1], "# Li Hao <lihao@example.com>", "author/email placeholders should render")
starts_with(rendered[2], "year=", "lua placeholder should render")
eq(rendered[3], "name=sample", "file name placeholder should render")
eq(rendered[4], "cursor=", "cursor placeholder should be removed from text")
eq(cursor[1], 4, "cursor line should be tracked")
eq(cursor[2], 8, "cursor column should point to placeholder position")

module.setup({
  temp_dir = templates_dir,
  author = vim.NIL,
  email = vim.NIL,
})

eq(module.author, "", "vim.NIL author should normalize to empty string")
eq(module.email, "", "vim.NIL email should normalize to empty string")

print("template tests passed")
