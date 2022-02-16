
" disable coc in text
autocmd FileType txt :CocDisable
autocmd FileType json :CocDisable
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')


hi CocHighlightText ctermbg=Gray guibg=#3e4452
hi link CocHighlightRead CocHighlightText
hi link CocHighlightWrite CocHighlightText
hi CocErrorSign ctermfg=Red guifg=#ff5370
hi CocWarningSign ctermfg=Brown guifg=#ffcb6b
hi CocInfoSign ctermfg=Yellow guifg=#bfc7d5
hi CocHintSign ctermfg=Blue guifg=#c3e88d

