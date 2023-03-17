vim.g.mapleader = ";"
------------------------ basic for nvim --------------------------------------
vim.g.is_win = (vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1)
vim.g.is_linux = (vim.fn.has('unix') == 1 and vim.fn.has('macunix') == 0)
vim.g.is_mac = vim.fn.has('macunix') == 1
vim.g.logging_level = 'info'
vim.g.is_bash=1

-- {{ Builtin variables
-- Disable Python2 support
vim.g.loaded_python_provider = 0

-- Disable perl provider
vim.g.loaded_perl_provider = 0

-- Disable ruby provider
vim.g.loaded_ruby_provider = 0

-- Disable node provider
vim.g.loaded_node_provider = 0

vim.g.did_install_default_menus = 1  -- do not load menu
-- Use English as main language


-- Path to Python 3 interpreter (must be an absolute path), make startup
-- faster. See https://neovim.io/doc/user/provider.html.
if vim.fn.executable('python') == 1 or vim.fn.executable('python3') == 1 then
  if vim.g.is_win then
    vim.g.python3_host_prog=vim.fn.substitute(vim.fn.exepath('python3'), '.exe$', '', 'g')
  elseif vim.g.is_linux or vim.g.is_mac then
    vim.g.python3_host_prog=vim.fn.exepath('python3')
    if vim.g.is_linux then
      vim.scriptencoding = 'utf-8'
      vim.opt.encoding = 'utf-8'
      vim.opt.fileencoding = 'utf-8'
    end
  end
else
  print('Python 3 executable not found! You must install Python 3 and set its PATH correctly!')
end


-- -------------------------- vars for plugins ---------------------------------

local plugin_conf_path = "$VIM_CONFIG_DIR/plugins"

vim.g.LanguageClient_serverStderr = '/tmp/clangd.stderr'

vim.g.username = vim.fn.getenv("NICKNAME")
vim.g.email = vim.fn.getenv("MAIL")
vim.g.licensee = vim.fn.getenv("LICENSE")

vim.g.vim_json_conceal=0
vim.g.markdown_syntax_conceal=0

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
