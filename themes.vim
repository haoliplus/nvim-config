""""""""""""""""""""""""
"" Color
"""""""""""""""""""""""
syntax on                                                                                      
set t_Co=256
set cursorcolumn
set cursorline
set background=dark
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Change comment in C++ to ///
autocmd FileType cpp setlocal commentstring=///\ %s
" Italics for my themes
let g:palenight_terminal_italics=1
" simily with 'highlight Comment cterm=italic gui=italic'
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

