vim.cmd(
[[
autocmd FileType python setl shiftwidth=4 tabstop=2 softtabstop=2
]])
-- Only for my specifical config file
vim.cmd(
[[
autocmd FileType yaml set nocursorcolumn
]]
)

vim.api.nvim_create_autocmd('FileType', {
	desc = 'Format python',

	pattern = 'python',
	-- group = vim.api.nvim_create_augroup('black_on_save', { clear = true }),
	callback = function (opts)
    vim.opt.shiftwidth=4
    vim.opt.tabstop=2
    vim.opt.softtabstop=2
	end,
})

-- Return to last edit position when opening files (You want this!)
vim.cmd(
[[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
-- """"""""""""""""""""""""""""""
-- " => Other
-- """"""""""""""""""""""""""""""
-- " Format json

vim.api.nvim_create_user_command(
  'FormatJson',
  function(input)
    vim.cmd("%!json_pp -json_opt utf8,pretty")
  end,
  {bang = true, desc = 'Format json'}
)

vim.api.nvim_create_user_command(
  'RmTrailingSpace',
  function(input)
    vim.cmd([[%s/\s\+$//e]])
  end,
  {bang = true, desc = 'clear space'}
)
