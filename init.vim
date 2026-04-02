" This file is called becaused of ${VIMINIT}

" replace , using \,
" append the parent directory to runtimepath
let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')
set guicursor=
set listchars=tab:>→,trail:~,eol:↵
set list
lua require('init')
