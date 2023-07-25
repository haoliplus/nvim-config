-- With a map leader it's possible to do extra key combinations
-- like <leader>w saves the current file
local keymap = vim.keymap
-- keymap.set('n', '<Leader>1', '1gt', { noremap = true, silent = true })
-- keymap.set('n', '<Leader>2', '2gt', { noremap = true, silent = true })
-- keymap.set('n', '<Leader>3', '3gt', { noremap = true, silent = true })
-- keymap.set('n', '<Leader>4', '4gt', { noremap = true, silent = true })
-- keymap.set('n', '<Leader>5', '5gt', { noremap = true, silent = true })
-- keymap.set('n', '<Leader>6', '6gt', { noremap = true, silent = true })
-- keymap.set('n', '<Leader>7', '7gt', { noremap = true, silent = true })
-- keymap.set('n', '<Leader>8', '8gt', { noremap = true, silent = true })
-- keymap.set('n', '<Leader>9', '9gt', { noremap = true, silent = true })
keymap.set('n', '<Leader>y', '"+y', { noremap = true, silent = true })
keymap.set('v', '<Leader>y', '"+y', { noremap = true, silent = true })
keymap.set('n', '<Leader>p', '"+p', { noremap = true, silent = true })
keymap.set('v', '<Leader>p', '"+p', { noremap = true, silent = true })

keymap.set('n', '<Leader>Y', ':w! ${HOME}/.vim_clipboard<CR>', { noremap = true, silent = true })
keymap.set('v', '<Leader>Y', ':w! ${HOME}/.vim_clipboard<CR>', { noremap = true, silent = true })
keymap.set('n', '<Leader>P', ':r! cat ${HOME}/.vim_clipboard<CR>', { noremap = true, silent = true })
keymap.set('v', '<Leader>P', ':r! cat ${HOME}/.vim_clipboard<CR>', { noremap = true, silent = true })

keymap.set('n', '<F1>', '<nop>', { noremap = true, silent = true })

keymap.set('n', '<A-j>', ':wincmd j<CR>', { noremap = true, silent = true })
keymap.set('n', '<A-k>', ':wincmd k<CR>', { noremap = true, silent = true })
keymap.set('n', '<A-h>', ':wincmd h<CR>', { noremap = true, silent = true })
keymap.set('n', '<A-l>', ':wincmd l<CR>', { noremap = true, silent = true })

keymap.set('n', '*', ':keepjumps normal! mi*`i<CR>', { noremap = true, silent = true })

-- nnoremap * :keepjumps normal! mi*`i<CR>

-- keymap.set('n', '<Leader>t', ':Template ',  { remap = true})
-- keymap.set('n', '<F10>', ':MRU', { noremap = true, silent = true })
