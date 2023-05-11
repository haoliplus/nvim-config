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

require('setup')
require('custom_filetype')

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

