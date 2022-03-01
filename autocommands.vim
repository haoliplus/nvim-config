" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Only format manually
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" FileType
autocmd FileType c,cpp,proto,javascript  let b:codefmt_formatter = 'clang-format'
autocmd FileType bzl let b:codefmt_formatter = 'buildifier'
autocmd FileType python let b:codefmt_formatter = 'yapf'
autocmd FileType python setl shiftwidth=4 tabstop=2 softtabstop=2
autocmd FileType fzf call feedkeys("i\<Bs>")
" Only for my specifical config file
autocmd FileType yaml set nocursorcolumn

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

""""""""""""""""""""""""""""""
" => Other
""""""""""""""""""""""""""""""
" Format json
command! FormatJSON %!json_pp -json_opt utf8,pretty
" remove trailing space
command! RMTS %s/\s\+$//e

