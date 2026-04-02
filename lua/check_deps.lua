local M = {}

local function missing_commands(commands)
  local missing = {}
  for name, cmd in pairs(commands) do
    if vim.fn.executable(cmd) ~= 1 then
      table.insert(missing, name)
    end
  end
  table.sort(missing)
  return missing
end

function M.check()
  local missing = missing_commands({
    git = "git",
    python3 = "python3",
  })

  if #missing == 0 then
    vim.notify("All checked dependencies are available.", vim.log.levels.INFO, {
      title = "CheckDeps",
    })
    return true
  end

  vim.notify("Missing dependencies: " .. table.concat(missing, ", "), vim.log.levels.WARN, {
    title = "CheckDeps",
  })
  return false
end

return M
