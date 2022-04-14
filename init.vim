let g:home_path=$HOME
let g:wiki_path=$WIKI_PATH
let s:config_path=$VIM_CONFIG_DIR
let s:plug_dir=$VIMPLUGDIR
if !has('nvim-0.6')
  set runtimepath=""
  finish
endif
let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')

execute printf('source %s/env.vim', s:config_path)
execute printf('source %s/plug_vars.vim', s:config_path)
execute printf('source %s/options.vim', s:config_path)
execute printf('source %s/mappings.vim', s:config_path)


call plug#begin(s:plug_dir)
" Utility for other plugin
Plug 'google/vim-glaive' , {'frozen': 1}
Plug 'google/vim-maktaba', {'frozen': 1}

" file tree explorer
Plug 'kyazdani42/nvim-web-devicons', {'frozen': 1}
Plug 'kyazdani42/nvim-tree.lua', {'frozen': 1}

" jump between .h/.cc
Plug 'vim-scripts/a.vim', {'frozen': 1}"
" Format code
Plug 'google/vim-codefmt', {'frozen': 1}
" syntax highlight
Plug 'jackguo380/vim-lsp-cxx-highlight', {'frozen': 1}
" Generate doc header and something
Plug 'vim-scripts/DoxygenToolkit.vim', {'frozen': 1}
" run command :AsyncRun[!]
Plug 'skywind3000/asyncrun.vim', {'frozen': 1}
" git 
Plug 'tpope/vim-fugitive', {'frozen': 1}
Plug 'airblade/vim-gitgutter', {'frozen': 1}
" Themes
Plug 'drewtempelmeyer/palenight.vim', {'frozen': 1}
" c-b show buffer
Plug 'jlanzarotta/bufexplorer', {'frozen': 1}
" quick commentary
Plug 'tpope/vim-commentary', {'frozen': 1}
" most recently used file
Plug 'vim-scripts/mru.vim', {'frozen': 1}
" fuzzy search using c-t
Plug 'junegunn/fzf', { 'do': './install --all', 'frozen': 1}
Plug 'junegunn/fzf.vim', {'frozen': 1}
" fuzzy search using c-p
Plug 'ctrlpvim/ctrlp.vim', {'frozen': 1}
" file template
Plug 'aperezdc/vim-template', {'frozen': 1}
" Using jj to escape
Plug 'jdhao/better-escape.vim'
" status
Plug 'itchyny/lightline.vim'
" show indent line
Plug 'Yggdroot/indentLine'

Plug 'neovim/nvim-lspconfig'
" lsp installer
Plug 'williamboman/nvim-lsp-installer'

" lsp complete
Plug 'hrsh7th/nvim-cmp'
" complete sources for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" For ultisnips users.
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" community-maintained snippets
" Plug 'honza/vim-snippets', {'frozen': 1}

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
lua require('packer_plugins')

execute printf('source %s/nvimrc', s:config_path)
execute printf('source %s/autocommands.vim', s:config_path)
