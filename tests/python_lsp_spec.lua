local root = vim.fn.getcwd()
package.path = package.path
  .. ";"
  .. root
  .. "/lua/?.lua;"
  .. root
  .. "/lua/?/init.lua"

local python_lsp = require("python_lsp")

local function eq(actual, expected, message)
  if actual ~= expected then
    error((message or "assertion failed") .. string.format("\nexpected: %s\nactual: %s", vim.inspect(expected), vim.inspect(actual)))
  end
end

python_lsp.use_ty = false
eq(python_lsp.type_checker_server(), "pyright", "pyright should remain the default type checker")
eq(vim.inspect(python_lsp.python_servers()), vim.inspect({ "pyright", "ruff" }), "python servers should default to pyright + ruff")

python_lsp.use_ty = true
eq(python_lsp.type_checker_server(), "ty", "ty should become the type checker when enabled")
eq(vim.inspect(python_lsp.python_servers()), vim.inspect({ "ty", "ruff" }), "python servers should switch to ty + ruff")

print("python lsp tests passed")
