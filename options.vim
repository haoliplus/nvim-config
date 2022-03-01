set nu " No line number
set nowrap " do not wrap line

set hidden
set cmdheight=1
set backspace=indent,eol,start 

set tabstop=2 " set tab display width #
set softtabstop=2 " set the backspace width # in backspace indent
set shiftwidth=2 "set the autoindent # width
"set space to replace tab
set expandtab
set mouse=

set updatetime=300

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Search
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=${HOME}/.cache/temp_dirs/undodir
    set undofile
catch
endtry
