""""""""""""""""""""""""
"" Color
"""""""""""""""""""""""
syntax on                                                                                      
set t_Co=256
set cursorcolumn
set cursorline
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
endif

" Override cursorline and cursorcolumn
let g:palenight_color_overrides = {
\    'cursor_grey': { "gui": "#3E4452", "cterm": "White", "cterm16": "White" },
\}
colorscheme palenight
set colorcolumn=80,120

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

