autocmd FileType python setl shiftwidth=2 tabstop=2 softtabstop=2


" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Only format manually
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Change comment in C++ to ///
autocmd FileType cpp setlocal commentstring=///\ %s

autocmd FileType c,cpp,proto,javascript  let b:codefmt_formatter = 'clang-format'
autocmd FileType bzl let b:codefmt_formatter = 'buildifier'
autocmd FileType python let b:codefmt_formatter = 'yapf'
autocmd FileType fzf call feedkeys("i\<Bs>")

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>


" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc 
" try
"   autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" catch
" endtry


""""""""""""""""""""""""""""""
" => Other
""""""""""""""""""""""""""""""
com! FormatJSON %!json_pp -json_opt utf8,pretty
