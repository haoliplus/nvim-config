-- """"""""""""""""""""""""""""""
-- " => Other
-- """"""""""""""""""""""""""""""
-- mason
vim.api.nvim_create_user_command("InitMasonPackage", function(_)
  vim.cmd("MasonInstall black@22.12.0 prettier ast-grep bash-language-server clangd lua-language-server --force ")
  vim.cmd(
    "MasonInstall pyright ruff rust-analyzer typescript-language-server isort@4.3.21 clangd gofumpt stylua --force"
  )
end, { bang = true, desc = "install mason" })

vim.api.nvim_create_user_command("Binary", function(_)
  vim.cmd("%!xxd")
end, { bang = true, desc = "read binary" })
-- " Format json
-- vim.api.nvim_create_user_command("FormatJson", function(_)
-- vim.cmd("%!json_pp -json_opt utf8,pretty")
-- end, { bang = true, desc = "Format json" })
--
vim.api.nvim_create_user_command("TrailingSpace", function(_)
  vim.cmd([[%s/\s\+$//e]])
end, { bang = true, desc = "clear space" })

-- vim.cmd(
--   [[
-- autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
-- ]])
-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd({ "BufRead", "BufReadPost" }, {
  callback = function()
    local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    local buf_line_count = vim.api.nvim_buf_line_count(0)

    if row >= 1 and row <= buf_line_count then
      vim.api.nvim_win_set_cursor(0, { row, column })
    end
  end,
})

-- 为 Python 文件类型创建一个自定义命令
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.api.nvim_create_user_command(
      "JsonFormat", -- 命令名称
      function()
        vim.cmd("%!json_pp -json_opt utf8,pretty")
      end,
      { desc = "format json" } -- 命令描述
    )
  end,
})

-- 当离开 Python 文件时，移除 DoLint 命令
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*.json",
  callback = function()
    if vim.fn.exists(":JsonFormat") == 2 then
      -- vim.cmd("silent! delcommand JsonFormat")
      vim.api.nvim_del_user_command("JsonFormat")
    end
  end,
})

-- if `./custom_command.lua` file exists
if vim.fn.filereadable(vim.fn.stdpath("config") .. "/lua/custom_command.lua") == 1 then
  -- load the file
  require("custom_command")
end
