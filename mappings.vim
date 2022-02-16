
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" command Json :%!json_pp -json_opt utf8,prett
command Json execute "!json_pp -json_opt utf8,pretty %"

