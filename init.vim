" This file is called becaused of ${VIMINIT}

" replace , using \,
" append the parent directory to runtimepath
let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')
set guicursor=
set listchars=trail:~,tab:>→,nbsp:␣,extends:◣,precedes:◢
" set listchars=eol:↵,trail:~,tab:>→,nbsp:␣,extends:◣,precedes:◢
set listchars=tab:>→,trail:~,eol:↵
" nnoremap * :keepjumps normal! mi*`i<CR>
" set listchars=eol:↵,trail:~,tab:→→,nbsp:␣,extends:◣,precedes:◢
" →
" tab:▷ ,trail:·,extends:◣,precedes:◢,nbsp:○
set list
lua require('init')
