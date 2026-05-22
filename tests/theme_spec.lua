local root = vim.fn.getcwd()
local theme_path = root .. "/lua/plugins/theme.lua"
local theme_source = table.concat(vim.fn.readfile(theme_path), "\n")

local function has_extension_icon(extension, icon)
  local pattern = '%["' .. extension .. '"%]%s*=%s*{[^}]-icon%s*=%s*"' .. icon .. '"'
  return theme_source:find(pattern) ~= nil
end

if not has_extension_icon("yaml", "") then
  error("yaml files should keep the configured devicon")
end

if not has_extension_icon("yml", "") then
  error("yml files should keep the configured devicon")
end

print("theme spec passed")
