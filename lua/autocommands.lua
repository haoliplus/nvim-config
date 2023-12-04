-- Only for my specifical config file
vim.api.nvim_create_autocmd("FileType", {
	desc = "yaml config",
	pattern = "yaml",
	-- group = vim.api.nvim_create_augroup('black_on_save', { clear = true }),
	callback = function(_)
		vim.opt.cursorcolumn = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Format python",
	pattern = "python",
	-- group = vim.api.nvim_create_augroup('black_on_save', { clear = true }),
	callback = function(_)
		vim.opt.shiftwidth = 4
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2
	end,
})
-- """"""""""""""""""""""""""""""
-- " => Other
-- """"""""""""""""""""""""""""""
-- " Format json
vim.api.nvim_create_user_command("FormatJson", function(_)
	vim.cmd("%!json_pp -json_opt utf8,pretty")
end, { bang = true, desc = "Format json" })

vim.api.nvim_create_user_command("TrailingSpace", function(_)
	vim.cmd([[%s/\s\+$//e]])
end, { bang = true, desc = "clear space" })

-- Return to last edit position when opening files (You want this!)
-- vim.cmd(
--   [[
-- autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
-- ]])
vim.api.nvim_create_autocmd({ "BufRead", "BufReadPost" }, {
	callback = function()
		local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
		local buf_line_count = vim.api.nvim_buf_line_count(0)

		if row >= 1 and row <= buf_line_count then
			vim.api.nvim_win_set_cursor(0, { row, column })
		end
	end,
})
