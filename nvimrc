" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt
map <leader>7 7gt
map <leader>8 8gt
map <leader>9 9gt
let g:username = $NICKNAME
let g:email = $MAIL
let g:licensee = $LICENSE

set cursorcolumn
set cursorline
set colorcolumn=80,120
" hi CursorLine term=bold cterm=bold guibg=53
hi CursorLine cterm=NONE ctermbg=8
hi CursorColumn cterm=NONE ctermbg=8 ctermfg=white
hi ColorColumn cterm=NONE ctermbg=8 ctermfg=white

nmap <F1> <nop>

nmap <A-j> :tabp <cr>
nmap <A-k> :tabn <cr>
nmap <c-j> :wincmd j<cr>
nmap <c-k> :wincmd k<cr>
nmap <c-h> :wincmd h<cr>
nmap <c-l> :wincmd l<cr>

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-f>'
map <c-b> :CtrlPBuffer<cr>

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" => NERDTree
""""""""""""""""""""""""""""""
map <F5> :NERDTreeToggle<cr>
nnoremap <silent> <expr><C-t> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<CR>"
nnoremap <silent> <expr><C-s> ":Vista finder\<CR>"

""""""""""""""""""""""""""""""
" => Coc
""""""""""""""""""""""""""""""
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" nnoremap <silent> <expr><A-s> ":CocList --interactive symbols\<CR>"
" " nmap <silent> <expr><Esc> coc#util#has_float() ? "\<Plug>(coc-float-hide)" : "<Esc>"
" nmap <silent> <expr><Esc> "\<Plug>(coc-float-hide)"
" nmap <silent> <expr><A-CR> "\<Plug>(coc-fix-current)"
" nmap <silent> <space> :call CocActionAsync('doHover')<cr>
" 
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "<C-n>" :
"       \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" 
" let g:coc_snippet_next = '<tab>'
" let g:coc_snippet_prev = '<S-tab>'
" 
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" nmap <silent> gn <Plug>(coc-diagnostic-next)
" nmap <silent> gp <Plug>(coc-diagnostic-prev)

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>

" set laststatus=0
set noshowmode
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
