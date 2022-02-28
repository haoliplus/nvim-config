let g:is_win = (has('win32') || has('win64')) ? v:true : v:false
let g:is_linux = (has('unix') && !has('macunix')) ? v:true : v:false
let g:is_mac = has('macunix') ? v:true : v:false
let g:logging_level = 'info'

let g:LanguageClient_serverStderr = '/tmp/clangd.stderr'
let g:NERDTreeGitStatusPorcelainVersion=1

let g:mapleader = ";"
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
    let g:python3_host_prog=substitute(exepath('python3'), '.exe$', '', 'g')
  elseif g:is_linux || g:is_mac
    let g:python3_host_prog=exepath('python3')
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

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
