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
let g:better_escape_shortcut = 'jj'

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
