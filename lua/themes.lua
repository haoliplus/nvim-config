
-- """"""""""""""""""""""""
-- "" Color
-- """""""""""""""""""""""
vim.cmd("syntax on")
vim.opt.cursorcolumn = true
vim.opt.cursorline = true

vim.opt.background=dark
vim.fn.setenv("NVIM_TUI_ENABLE_TRUE_COLOR", 1)

-- Change comment in C++ to ///
vim.cmd([[autocmd FileType cpp setlocal commentstring=///\ %s]])
-- Italics for my themes
vim.g.palenight_terminal_italics=1
-- simily with 'highlight Comment cterm=italic gui=italic'
-- Override cursorline and cursorcolumn
vim.g.palenight_color_overrides = {
    cursor_grey= { gui= "#3E4452", cterm= "White", cterm16= "White" },
}

vim.cmd('colorscheme palenight')

vim.opt.colorcolumn={80,120}

if vim.fn.exists('+termguicolors') == 1 then
  vim.cmd([[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]])
  vim.cmd([[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]])
  vim.opt.termguicolors = true
end
