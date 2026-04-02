local M = {
  use_ty = true,
}

function M.type_checker_server()
  return M.use_ty and "ty" or "pyright"
end

function M.python_servers()
  return {
    M.type_checker_server(),
    "ruff",
  }
end

return M
