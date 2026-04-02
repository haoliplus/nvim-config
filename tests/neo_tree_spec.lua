local layout_source = table.concat(vim.fn.readfile("lua/plugins/layout.lua"), "\n")

local required_patterns = {
  "__pycache__",
  "%.egg%-info",
  "%.egg_info",
  "%.pytest_cache",
  "%.mypy_cache",
  "%.ruff_cache",
  "%.tox",
  "%.nox",
  "htmlcov",
  "%.venv",
  "dist",
  "build",
  "%.cache",
}

for _, pattern in ipairs(required_patterns) do
  if not layout_source:find(pattern) then
    error("neo-tree hidden items should include pattern: " .. pattern)
  end
end

print("neo-tree spec passed")
