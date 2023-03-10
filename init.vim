let g:home_path=$HOME
let g:wiki_path=$WIKI_PATH
let s:config_path=$VIM_CONFIG_DIR
let s:plug_dir=$VIMPLUGDIR
if !has('nvim-0.6')
  set runtimepath=""
  finish
endif
" Relative path of script file:
" let s:path = expand('<sfile>')

" Absolute path of script file:
" let s:path = expand('<sfile>:p')

" Absolute path of script file with symbolic links resolved:
" let s:path = resolve(expand('<sfile>:p'))

" Folder in which script resides: (not safe for symlinks)
" let s:path = expand('<sfile>:p:h')

" replace , using \,
let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')

execute printf('source %s/var.vim', s:config_path)
execute printf('source %s/options.vim', s:config_path)

" let g:plug_url_format='http://git::@hub.fastgit.org/%s.git'

call plug#begin(s:plug_dir)
" Utility for other plugin
Plug 'google/vim-glaive'
Plug 'google/vim-maktaba'

Plug 'neovim/nvim-lspconfig'
" file tree explorer
Plug 'kyazdani42/nvim-web-devicons'
" tree will be loaded on the first invocation of NvimTreeToggle command

" jump between .h/.cc
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
" Format code
Plug 'google/vim-codefmt'
" syntax highlight
Plug 'jackguo380/vim-lsp-cxx-highlight'
" Generate doc header and something
Plug 'vim-scripts/DoxygenToolkit.vim'
" run command :AsyncRun[!]
Plug 'skywind3000/asyncrun.vim'
" git 
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Themes
Plug 'drewtempelmeyer/palenight.vim'
" c-b show buffer
Plug 'jlanzarotta/bufexplorer'
" quick commentary
Plug 'tpope/vim-commentary'
" most recently used file
Plug 'vim-scripts/mru.vim'
" fuzzy search using c-t
Plug 'junegunn/fzf', { 'do': './install --all'}
Plug 'junegunn/fzf.vim'
" fuzzy search using c-p
Plug 'ctrlpvim/ctrlp.vim'
" file template
" Plug 'aperezdc/vim-template'
Plug 'tibabit/vim-templates'
" Using jj to escape
Plug 'jdhao/better-escape.vim'
" status bar
Plug 'itchyny/lightline.vim'
" show indent line
Plug 'Yggdroot/indentLine'

" lsp installer
Plug 'williamboman/nvim-lsp-installer'

" lsp complete
Plug 'hrsh7th/nvim-cmp'
" complete sources for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'haoliplus/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" For ultisnips users.
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" community-maintained snippets
" Plug 'honza/vim-snippets', {'frozen': 1}
Plug 'mileszs/ack.vim'

Plug 'nvim-tree/nvim-tree.lua'
" Optional
if isdirectory(g:wiki_path)
  Plug 'haoliplus/vimwiki', {'frozen': 1}
endif

call plug#end()

try
  call glaive#Install()
catch 
  finish
endtry

execute printf('source %s/themes.vim', s:config_path)

lua require('init')

execute printf('source %s/custom.vim', s:config_path)
execute printf('source %s/autocommands.vim', s:config_path)
