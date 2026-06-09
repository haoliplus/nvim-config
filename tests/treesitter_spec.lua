local root = vim.fn.getcwd()
local theme_path = root .. "/lua/plugins/theme.lua"
local theme_source = table.concat(vim.fn.readfile(theme_path), "\n")

if
  not theme_source:find('plugin.dir .. "/runtime"', 1, true)
  or not theme_source:find("vim.opt.rtp:prepend(query_runtime)", 1, true)
then
  error("nvim-treesitter runtime directory should be prepended so bundled queries are visible")
end

print("treesitter spec passed")
