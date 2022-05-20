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

nmap <A-j> :wincmd j<cr>
nmap <A-k> :wincmd k<cr>
nmap <A-h> :wincmd h<cr>
nmap <A-l> :wincmd l<cr>

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-f>'

" FZF
nmap <F6> :Buffers<cr>
nmap <F7> :Marks<cr>

nnoremap <Leader>a :Ack<Space>

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
map <leader>f :MRU<CR>
nmap <F8> :MRU<CR>

""""""""""""""""""""""""""""""
" => NvimTree
""""""""""""""""""""""""""""""
map <F5> :NvimTreeToggle<cr>
