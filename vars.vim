let g:is_win = (has('win32') || has('win64')) ? v:true : v:false
let g:is_linux = (has('unix') && !has('macunix')) ? v:true : v:false
let g:is_mac = has('macunix') ? v:true : v:false
let g:logging_level = 'info'

let g:LanguageClient_serverStderr = '/tmp/clangd.stderr'

let g:mapleader = ";"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=${HOME}/.cache/temp_dirs/undodir
    set undofile
catch
endtry
"{{ Builtin variables
" Disable Python2 support
let g:loaded_python_provider = 0

" Disable perl provider
let g:loaded_perl_provider = 0

" Disable ruby provider
let g:loaded_ruby_provider = 0

" Disable node provider
let g:loaded_node_provider = 0

let g:did_install_default_menus = 1  " do not load menu
" Use English as main language
language en_US.utf-8


" Path to Python 3 interpreter (must be an absolute path), make startup
" faster. See https://neovim.io/doc/user/provider.html.
if executable('python')
   if g:is_win
    let g:python3_host_prog=substitute(exepath('python'), '.exe$', '', 'g')
  elseif g:is_linux || g:is_mac
    let g:python3_host_prog=exepath('python')
  endif
else
  echoerr 'Python 3 executable not found! You must install Python 3 and set its PATH correctly!'
endif

" VIMWIKI
let g:vimwiki_list = [{'path': g:wiki_path.'/text/',
       \ 'index':'Home',
       \ 'path_html': g:wiki_path.'/html/',
       \ 'syntax': 'markdown',
       \ 'inner_link_syntax': 'mediawiki',
       \ 'ext': '.md',
       \ 'auto_diary_index': 1,
       \ 'diary_rel_path': 'summary/diary/',
       \ 'auto_generate_links': 1,
       \ 'template_path': g:wiki_path.'/templates/',
       \ 'template_default': 'def_template',
       \ 'template_ext': '.html'}]

let g:vimwiki_hl_headers = 1
let g:vimwiki_global_ext = 0

" NERDTree

" Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    let t:NERDTreeTabLastWindow = winnr()
    silent! NERDTreeFind
    NERDTreeFocus
    exec t:NERDTreeTabLastWindow . "wincmd w"
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

let NERDTreeShowLineNumber = 1
let NERDTreeAutoCentor = 1
let NERDTreeShowBookmarks = 1

" only open NERDTree on console if dir was given
" if set to 1, it always open NERDTree
" if set to 0, it will not open NERDTree
let g:nerdtree_tabs_open_on_console_startup=0

" focus NREDTree if opening a dir, focus file if opening a file
let g:nerdtree_tabs_smart_startup_focus=1

let NERDTreeIgnore=['\.pyc','\~$','\.swp', '\.o']

let g:NERDSpaceDelims = 0
let g:NERDTreeGitStatusIncludeSubmodules=1

let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "~",
    \ "Renamed"   : "»",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "-",
    \ "Dirty"     : "•",
    \ "Clean"     : "✓",
    \ 'Ignored'   : "~",
    \ "Unknown"   : "?"
    \ }

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

