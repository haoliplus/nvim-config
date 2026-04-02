local root = vim.fn.getcwd()
package.path = package.path
  .. ";"
  .. root
  .. "/lua/?.lua;"
  .. root
  .. "/lua/?/init.lua"

local workspace = require("python_workspace")

local function eq(actual, expected, message)
  if actual ~= expected then
    error((message or "assertion failed") .. string.format("\nexpected: %s\nactual: %s", vim.inspect(expected), vim.inspect(actual)))
  end
end

local tmp = vim.fn.tempname()
vim.fn.mkdir(tmp, "p")

local uv_root = tmp .. "/repo"
local pkg_root = uv_root .. "/packages/app"
local venv_bin = uv_root .. "/.venv/bin"
vim.fn.mkdir(pkg_root, "p")
vim.fn.mkdir(venv_bin, "p")
vim.fn.writefile({ "[project]", 'name = "workspace-root"', "", "[tool.uv.workspace]", 'members = ["packages/*"]' }, uv_root .. "/pyproject.toml")
vim.fn.writefile({ "version = 1" }, uv_root .. "/uv.lock")
vim.fn.writefile({ "#!/usr/bin/env python3" }, venv_bin .. "/python")
vim.fn.writefile({ "[project]", 'name = "app"' }, pkg_root .. "/pyproject.toml")
vim.fn.writefile({ "print('hi')" }, pkg_root .. "/main.py")

local file = pkg_root .. "/main.py"

eq(workspace.current_python_workspace(file), uv_root, "uv workspace root should win over nested package pyproject")
eq(workspace.get_python_path(uv_root), venv_bin .. "/python", "workspace .venv python should be selected")

local plain_root = tmp .. "/plain"
local plain_bin = plain_root .. "/.venv/bin"
vim.fn.mkdir(plain_bin, "p")
vim.fn.writefile({ "[project]", 'name = "plain"' }, plain_root .. "/pyproject.toml")
vim.fn.writefile({ "#!/usr/bin/env python3" }, plain_bin .. "/python")
vim.fn.writefile({ "print('plain')" }, plain_root .. "/plain.py")

eq(workspace.current_python_workspace(plain_root .. "/plain.py"), plain_root, "plain project root should stay local")
eq(workspace.get_python_path(plain_root), plain_bin .. "/python", "plain project .venv python should be selected")

print("python workspace tests passed")
