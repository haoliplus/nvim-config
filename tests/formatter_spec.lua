local root = vim.fn.getcwd()
local formatter_path = root .. "/lua/plugins/formatter.lua"
local plugins = dofile(formatter_path)
local formatter_source = table.concat(vim.fn.readfile(formatter_path), "\n")

local function eq(actual, expected, message)
  if actual ~= expected then
    error((message or "assertion failed") .. string.format("\nexpected: %s\nactual: %s", vim.inspect(expected), vim.inspect(actual)))
  end
end

eq(type(plugins), "table", "formatter plugin spec should be a table")
eq(plugins[1][1], "stevearc/conform.nvim", "formatter plugin should migrate to conform.nvim")
if not formatter_source:find('vim%.keymap%.set%("x", "<Leader>F"') then
  error("formatter plugin should provide a visual mode <Leader>F mapping")
end
if not formatter_source:find('nvim_create_user_command%("F", format_write_command, { desc = "FormatWrite", range = true }%)') then
  error("formatter plugin should allow :F on a visual range")
end

print("formatter plugin spec passed")
