let g:home_path=$HOME
let g:wiki_path=$WIKI_PATH
let s:config_path=$VIM_CONFIG_DIR
let s:plug_dir=$VIMPLUGDIR
let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')

execute printf('source %s/func.vim', s:config_path)
execute printf('source %s/vars.vim', s:config_path)
execute printf('source %s/options.vim', s:config_path)
execute printf('source %s/mappings.vim', s:config_path)
execute printf('source %s/autocommands.vim', s:config_path)

call plug#begin(s:plug_dir)
" file explorer
Plug 'scrooloose/nerdtree' , {'frozen': 1}
" Git symbol for nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin', {'frozen': 1}
Plug 'jistr/vim-nerdtree-tabs' , {'frozen': 1}
Plug 'google/vim-maktaba', {'frozen': 1}
Plug 'google/vim-codefmt', {'frozen': 1}
Plug 'google/vim-glaive' , {'frozen': 1}
" syntax highlight
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'vim-scripts/a.vim', {'frozen': 1}
Plug 'junegunn/fzf', { 'do': './install --all', 'frozen': 1}
Plug 'junegunn/fzf.vim', {'frozen': 1}
Plug 'vim-scripts/DoxygenToolkit.vim', {'frozen': 1}
Plug 'skywind3000/asyncrun.vim', {'frozen': 1}
Plug 'tpope/vim-fugitive', {'frozen': 1}
" Themes
Plug 'drewtempelmeyer/palenight.vim', {'frozen': 1}
Plug 'jlanzarotta/bufexplorer', {'frozen': 1}
Plug 'tpope/vim-commentary', {'frozen': 1}
" most recently used file
Plug 'vim-scripts/mru.vim', {'frozen': 1}
Plug 'kien/ctrlp.vim', {'frozen': 1}
Plug 'aperezdc/vim-template', {'frozen': 1}
" Using jj to escape
Plug 'jdhao/better-escape.vim'
Plug 'itchyny/lightline.vim'
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
Plug 'honza/vim-snippets', {'frozen': 1}

" Optional
if isdirectory(g:wiki_path)
  Plug 'haoliplus/vimwiki', {'frozen': 1}
endif

call plug#end()

call glaive#Install()

set completeopt=menu,menuone,noselect

lua require('init')

execute printf('source %s/plugin.vim', s:config_path)
execute printf('source %s/nvimrc', s:config_path)
execute printf('source %s/themes.vim', s:config_path)
