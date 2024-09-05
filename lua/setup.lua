vim.cmd("autocmd!") -- Remove all auto cmd
vim.g.mapleader = ";"
------------------------ basic for nvim --------------------------------------
vim.g.is_bash = 1
vim.g.conceallevel = 0

-- {{ Builtin variables
-- Disable Python2 support
vim.g.loaded_python_provider = 0

-- Disable perl provider
vim.g.loaded_perl_provider = 0

-- Disable ruby provider
vim.g.loaded_ruby_provider = 0

-- Disable node provider
vim.g.loaded_node_provider = 0

vim.g.did_install_default_menus = 1 -- do not load menu
-- Use English as main language

-- Path to Python 3 interpreter (must be an absolute path), make startup
-- faster. See https://neovim.io/doc/user/provider.html.
if
  vim.fn.executable("python3.exe")
  or vim.fn.executable("python") == 1
  or vim.fn.executable("python3") == 1
  or vim.fn.executable("/usr/bin/python3") == 1
  or vim.fn.executable("/usr/bin/python2") == 1
then
  if vim.g.is_win then
    vim.g.python3_host_prog = vim.fn.substitute(vim.fn.exepath("python3"), ".exe$", "", "g")
  elseif vim.g.is_linux or vim.g.is_mac then
    if vim.g.is_linux then
      if vim.fn.executable("/usr/bin/python3") == 1 then
        vim.g.python3_host_prog = vim.fn.exepath("/usr/bin/python3")
      else
        vim.g.python3_host_prog = vim.fn.exepath("python3")
      end
      vim.scriptencoding = "utf-8"
      vim.opt.encoding = "utf-8"
      vim.opt.fileencoding = "utf-8"
    else
      vim.g.python3_host_prog = vim.fn.exepath("python3")
    end
  end
else
  print("Python 3 executable not found! You must install Python 3 and set its PATH correctly!")
end

-- -------------------------- vars for plugins ---------------------------------

vim.g.LanguageClient_serverStderr = "/tmp/clangd.stderr"

vim.g.username = vim.fn.getenv("NICKNAME")
vim.g.email = vim.fn.getenv("MAIL")
vim.g.licensee = vim.fn.getenv("LICENSE")

vim.g.vim_json_conceal = 0
vim.g.markdown_syntax_conceal = 0

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
-- -------------------------------------------------------------------------------------------

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true -- No line number

vim.opt.wrap = false -- do not wrap line

vim.opt.hidden = true
vim.opt.cmdheight = 1
vim.opt.backspace = { "indent", "eol", "start" }

vim.opt.tabstop = 2 -- set tab display width #
vim.opt.softtabstop = 2 -- set the backspace width # in backspace indent
vim.opt.shiftwidth = 2 -- set the autoindent # width
--set space to replace tab
vim.opt.expandtab = true
vim.opt.mouse = ""

vim.opt.updatetime = 300

vim.opt.conceallevel = 0

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
vim.opt.undodir = vim.fn.getenv("HOME") .. "/.cache/temp_dirs/undodir"
vim.opt.undofile = true
vim.opt.splitright = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- vim.loop to vim.uv
if not vim.uv.fs_stat(lazypath) then
  print("cloning lazy.nvim... " .. lazypath)
  vim.fn.system({
    "git",
    "clone",
    -- "--filter=blob:none", -- this require git version
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
