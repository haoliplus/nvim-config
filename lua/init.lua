#! /usr/bin/env lua
--
-- init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

function Contains(list, x)
	for _, v in pairs(list) do
		if v == x then return true end
	end
	return false
end

vim.g.home_path=vim.fn.getenv("HOME")
vim.g.wiki_path=vim.fn.getenv("WIKI_PATH")
vim.g.config_path=vim.fn.getenv("VIM_CONFIG_DIR")
vim.g.plug_dir=vim.fn.getenv("VIMPLUGDIR")
vim.opt.rtp:prepend(vim.g.config_path)

if vim.fn.isdirectory(vim.g.config_path) == 0 then
  vim.g.config_path=vim.g.home_path.."/.config/nvim"
end
if vim.fn.isdirectory(vim.g.wiki_path) == 0 then
  vim.g.wiki_path=vim.g.home_path.."/vimwiki"
end

require('setup')
require('custom_filetype')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath .. "/lua/lazy/init.lua") then
  print("lazy.nvim loading failed.")
  return
end

require("lazy").setup("plugins", {
  performance = {
    rpt = {
      paths = {vim.g.config_path}
    }
  }
})

require('themes')
require('keymap')
require('autocommands')

-- local status, ret = pcall(call_requires)

-- if (not status) then
--   print("Failed to init")
--   print(ret)
--   return
-- end

