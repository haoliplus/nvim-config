" This file is called becaused of ${VIMINIT}

" Relative path of script file:
" let s:path = expand('<sfile>')

" Absolute path of script file:
" let s:path = expand('<sfile>:p')

" Absolute path of script file with symbolic links resolved:
" let s:path = resolve(expand('<sfile>:p'))

" Folder in which script resides: (not safe for symlinks)
" let s:path = expand('<sfile>:p:h')

" replace , using \,
" append the parent directory to runtimepath
let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')
set guicursor=
set listchars=trail:~,tab:>→,nbsp:␣,extends:◣,precedes:◢
" set listchars=eol:↵,trail:~,tab:>→,nbsp:␣,extends:◣,precedes:◢
" nnoremap * :keepjumps normal! mi*`i<CR>
" set listchars=eol:↵,trail:~,tab:→→,nbsp:␣,extends:◣,precedes:◢
" →
" tab:▷ ,trail:·,extends:◣,precedes:◢,nbsp:○
set nolist

lua require('init')
