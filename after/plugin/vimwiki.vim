""""""""""""""""""""""""""""""
" => vimwiki
""""""""""""""""""""""""""""""
" Auto-save
autocmd BufNewFile,BufRead */vimwiki/**.md :autocmd TextChanged,TextChangedI <buffer> silent write
