local root = vim.fn.getcwd()
local theme_path = root .. "/lua/plugins/theme.lua"
local theme_source = table.concat(vim.fn.readfile(theme_path), "\n")
local ui_path = root .. "/lua/plugins/ui.lua"
local ui_source = table.concat(vim.fn.readfile(ui_path), "\n")
local lock_path = root .. "/lazy-lock.json"
local lock_source = table.concat(vim.fn.readfile(lock_path), "\n")

if not theme_source:find("vim.treesitter.start", 1, true) then
  error("built-in treesitter should start from the FileType autocmd")
end

if theme_source:find("nvim%-treesitter") or ui_source:find("nvim%-treesitter") or lock_source:find("nvim%-treesitter") then
  error("nvim-treesitter plugin should not be configured")
end

print("treesitter spec passed")
