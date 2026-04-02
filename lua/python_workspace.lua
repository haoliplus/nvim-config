local M = {}

local function path_exists(path)
  return path and vim.uv.fs_stat(path) ~= nil
end

local function join_path(...)
  return table.concat({ ... }, "/")
end

local function python_from_venv(venv)
  if not venv or venv == "" then
    return nil
  end
  local python = join_path(venv, "bin", "python")
  if path_exists(python) then
    return python
  end
  python = join_path(venv, "Scripts", "python.exe")
  if path_exists(python) then
    return python
  end
  return nil
end

local function file_dir(file)
  if file == nil or file == "" then
    return nil
  end
  return vim.fn.isdirectory(file) == 1 and file or vim.fs.dirname(file)
end

local function current_python_file(bufnr_or_file)
  if type(bufnr_or_file) == "string" then
    return bufnr_or_file
  end

  local name = vim.api.nvim_buf_get_name(bufnr_or_file or 0)
  if name ~= "" then
    return name
  end
  return vim.fn.expand("%:p")
end

local function is_uv_workspace_root(dir)
  if not dir or dir == "" then
    return false
  end

  if path_exists(join_path(dir, "uv.lock")) then
    return true
  end

  local pyproject = join_path(dir, "pyproject.toml")
  if not path_exists(pyproject) then
    return false
  end

  for line in io.lines(pyproject) do
    if line:match("^%[tool%.uv%.workspace%]") then
      return true
    end
  end

  return false
end

local function find_ancestor_venv(start_dir)
  local dir = file_dir(start_dir)
  if not dir then
    return nil
  end

  if python_from_venv(join_path(dir, ".venv")) then
    return dir
  end

  for parent in vim.fs.parents(dir) do
    if python_from_venv(join_path(parent, ".venv")) then
      return parent
    end
  end

  return nil
end

local function nearest_python_root(file)
  local path = vim.fs.root(file, {
    "pyrightconfig.json",
    "setup.py",
    "setup.cfg",
    "pyproject.toml",
    "requirements.txt",
    "Pipfile",
    ".git",
  })
  if path then
    return path
  end

  local current_file = current_python_file(file)
  if current_file ~= "" then
    return vim.fs.dirname(current_file)
  end
  return vim.fn.getcwd()
end

function M.current_python_workspace(bufnr_or_file)
  local file = current_python_file(bufnr_or_file)
  local root = nearest_python_root(file)
  local dir = file_dir(root)

  if dir then
    if is_uv_workspace_root(dir) and python_from_venv(join_path(dir, ".venv")) then
      return dir
    end

    for parent in vim.fs.parents(dir) do
      if is_uv_workspace_root(parent) and python_from_venv(join_path(parent, ".venv")) then
        return parent
      end
      if path_exists(join_path(parent, ".git")) then
        break
      end
    end
  end

  return root
end

function M.get_python_path(workspace)
  workspace = workspace or vim.fn.getcwd()

  local activated = python_from_venv(vim.env.VIRTUAL_ENV)
  if activated then
    return activated
  end

  local venv_root = find_ancestor_venv(workspace)
  if venv_root then
    local local_python = python_from_venv(join_path(venv_root, ".venv"))
    if local_python then
      return local_python
    end
  end

  if vim.fn.executable("python3") == 1 then
    return vim.fn.exepath("python3")
  end
  return vim.fn.exepath("python")
end

return M
