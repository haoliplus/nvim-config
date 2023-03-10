vim.cmd("autocmd!") -- what is this

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true -- No line number

vim.opt.wrap=false -- do not wrap line

vim.opt.hidden = true
vim.opt.cmdheight = 1
vim.opt.backspace = {"indent", "eol", "start"}

vim.opt.tabstop = 2 -- set tab display width #
vim.opt.softtabstop = 2 -- set the backspace width # in backspace indent
vim.opt.shiftwidth = 2 -- set the autoindent # width
--set space to replace tab
vim.opt.expandtab = true
vim.opt.mouse = ""

vim.opt.updatetime = 300

-- """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- => Files, backups and undo
-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- " Turn backup off, since most stuff is in SVN, git et.c anyway...
vim.opt.backup = false
vim.opt.wb = false
vim.opt.swapfile = false

-- Search
-- Ignore case when searching
vim.opt.ignorecase = true
-- When searching try to be smart about cases 
vim.opt.smartcase = true

-- """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--  => Turn persistent undo on 
--     means that you can undo even when you close a buffer/VIM
-- """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vim.opt.undodir=vim.fn.getenv("HOME").. "/.cache/temp_dirs/undodir"
vim.opt.undofile=true
