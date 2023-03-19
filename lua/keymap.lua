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

keymap.set('n', '<F1>', '<nop>', { noremap = true, silent = true })

keymap.set('n', '<A-j>', ':wincmd j<CR>', { noremap = true, silent = true })
keymap.set('n', '<A-k>', ':wincmd k<CR>', { noremap = true, silent = true })
keymap.set('n', '<A-h>', ':wincmd h<CR>', { noremap = true, silent = true })
keymap.set('n', '<A-l>', ':wincmd l<CR>', { noremap = true, silent = true })

--"""""""""""""""""""""""""""""
-- => CTRL-P
--"""""""""""""""""""""""""""""
vim.g.ctrlp_map = '<c-f>'

keymap.set('n', '<F6>', ':Buffers<CR>', { noremap = true, silent = true })
keymap.set('n', '<F7>', ':Marks<CR>', { noremap = true, silent = true })

keymap.set('n', '<Leader>a', ':Ack<Space>', { noremap = true, silent = true })

-- """"""""""""""""""""""""""""""
-- " => MRU plugin
-- """"""""""""""""""""""""""""""
keymap.set('n', '<Leader>f', ':MRU<CR>', { noremap = true, silent = true })
keymap.set('n', '<F8>', ':MRU<CR>', { noremap = true, silent = true })
keymap.set('n', '<F5>', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
