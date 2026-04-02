vim.g.mapleader = ";"
------------------------ basic for nvim --------------------------------------
vim.g.is_bash = 1

-- {{ Builtin variables
-- Disable Python2 support
vim.g.loaded_python_provider = 0

-- Disable perl provider
vim.g.loaded_perl_provider = 0

-- Disable ruby provider
vim.g.loaded_ruby_provider = 0

vim.g.did_install_default_menus = 1 -- do not load menu
-- Use English as main language

-- Path to Python 3 interpreter (must be an absolute path), make startup
-- faster. See https://neovim.io/doc/user/provider.html.
local python_candidates = {}
if vim.g.is_linux then
  table.insert(python_candidates, vim.fn.getenv("HOME") .. "/.local/share/mise/shims/python")
  table.insert(python_candidates, "/usr/bin/python3")
end
if vim.g.is_win then
  table.insert(python_candidates, "python3.exe")
end
table.insert(python_candidates, "python3")
table.insert(python_candidates, "python")

for _, candidate in ipairs(python_candidates) do
  if vim.fn.executable(candidate) == 1 then
    vim.g.python3_host_prog = vim.fn.exepath(candidate)
    break
  end
end

if not vim.g.python3_host_prog or vim.g.python3_host_prog == "" then
  vim.notify_once("Python 3 executable not found. Install Python 3 and ensure it is available on PATH.", vim.log.levels.WARN, {
    title = "setup",
  })
end

-- -------------------------- vars for plugins ---------------------------------

-- vim.g.LanguageClient_serverStderr = "/tmp/clangd.stderr"

vim.g.username = vim.fn.getenv("NICKNAME")
vim.g.email = vim.fn.getenv("MAIL")
vim.g.licensee = vim.fn.getenv("LICENSE")

vim.g.vim_json_conceal = 0
vim.g.markdown_syntax_conceal = 0

-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
-- -------------------------------------------------------------------------------------------

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

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
local undodir = vim.fn.getenv("HOME") .. "/.cache/nvim_temp_dirs/undodir"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir
vim.opt.undofile = true
vim.opt.splitright = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local result = vim.fn.system({
    "git",
    "clone",
    -- "--filter=blob:none", -- this require git version
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to clone lazy.nvim:\n" .. result, vim.log.levels.ERROR, { title = "setup" })
    return
  end
end
vim.opt.rtp:prepend(lazypath)
