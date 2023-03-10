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

-- Return to last edit position when opening files (You want this!)
vim.cmd(
[[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
-- """"""""""""""""""""""""""""""
-- " => Other
-- """"""""""""""""""""""""""""""
-- " Format json

-- command! FormatJSON %!json_pp -json_opt utf8,pretty
-- remove trailing space
-- command! RmTrailingSpace %s/\s\+$//e


