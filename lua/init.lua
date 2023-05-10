#! /usr/bin/env lua
--
-- init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

function contains(list, x)
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
if not contains(vim.api.nvim_list_runtime_paths(), vim.g.config_path) then
  print(vim.inspect(vim.api.nvim_list_runtime_paths()))
end

require('setup')
require('custom_filetype')

-- print(vim.inspect(vim.api.nvim_list_runtime_paths()))
require("lazy").setup("plugins")

if not contains(vim.api.nvim_list_runtime_paths(), vim.g.config_path) then
  -- print(vim.inspect(vim.api.nvim_list_runtime_paths()))
  print(contains(vim.api.nvim_list_runtime_paths(), vim.g.config_path))
  vim.opt.rtp:prepend(vim.g.config_path)
else
end

-- vim.opt.rtp:prepend(vim.g.config_path)
require('themes')
require('keymap')
require('autocommands')

-- local status, ret = pcall(call_requires)

-- if (not status) then
--   print("Failed to init")
--   print(ret)
--   return
-- end

