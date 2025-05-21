-- init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

if vim.fn.has("nvim-0.9") == 0 then
  print("Neovim version is too old, please update to 0.9 or later.")
  return
end

-- another way to check nvim version
if vim.version().major == 0 and vim.version().minor < 9 then
  print("Neovim version is too old, please update to 0.9 or later.")
  return
end

vim.g.is_win = (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1)
vim.g.is_linux = (vim.fn.has("unix") == 1 and vim.fn.has("macunix") == 0)
vim.g.is_mac = vim.fn.has("macunix") == 1
vim.g.logging_level = "info"
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

function Contains(list, x)
  for _, v in pairs(list) do
    if v == x then
      return true
    end
  end
  return false
end

vim.g.home_path = vim.fn.getenv("HOME")
vim.g.config_path = vim.fn.getenv("VIM_CONFIG_DIR")
vim.g.clipboard = {
  name = "myClipboard",
  cache_enabled = 1,
  copy = {
    ["+"] = { "tmux", "load-buffer", "-" },
    ["*"] = { "tmux", "load-buffer", "-" },
  },
  paste = {
    ["+"] = { "tmux", "save-buffer", "-" },
    ["*"] = { "tmux", "save-buffer", "-" },
  },
}

if vim.g.is_linux or vim.g.is_mac then
  if vim.fn.isdirectory(vim.g.config_path) == 0 then
    vim.g.config_path = vim.g.home_path .. "/.config/nvim"
  end
elseif vim.g.is_win then
  if vim.fn.isdirectory(vim.g.config_path) == 0 then
    vim.g.config_path = vim.g.home_path .. "/AppData/Local/nvim"
  end
else
  print(vim.inspect(vim.g)) -- use `:messages` to see the log
end
vim.opt.rtp:prepend(vim.g.config_path)

-- disable vim deprecated notification
vim.deprecate = function() end

require("setup")
require("custom_filetype")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath .. "/lua/lazy/init.lua") then
  print("lazy.nvim loading failed.")
  return
end

require("lazy").setup("plugins", {
  git = {
    filter = false,
  },
  ui = {
    border = "rounded",
  },
  performance = {
    rpt = {
      paths = { vim.g.config_path },
    },
  },
})

require("check_deps")
local function call_requires()
  require("my_utils")
  require("themes")
  require("keymap")
  require("autocommands")
end

local status, ret = pcall(call_requires)

if not status then
  print("Failed to init")
  print(ret)
  return
end

-- sample for my function
function _G.show_my_text()
  require("notify")([[
  My super important
  message
  node
  ]])
end
vim.keymap.set("n", "<c-h>", show_my_text, { desc = "Show my text" })
-- nnoremap <leader>h :lua show_my_text()<CR>

-- local sample_exe = vim.fn.executable("isort")

-- local ok, result = pcall(
--   vim.cmd,'!isort --version > /dev/null 2>&1'
--   -- 'isort --version 2&>1 /dev/null'
-- )
-- local ok, result = pcall(
--   vim.cmd, -- ignore
--   'isort --version > /dev/null 2>&1'
-- )
--   -- vim.cmd('isort --version 2&>1 /dev/null')
--
-- require("notify")("isort: " .. sample_exe .. " " .. tostring(ok) .. " " .. tostring(result), "info ", { title = "Formatter" })

-------------------------------------
-- Set border for floating windows
local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _border,
})

vim.diagnostic.config({
  float = { border = _border },
})
-----------------------------------------------------------------
