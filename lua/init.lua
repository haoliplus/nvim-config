#! /usr/bin/env lua
--
-- init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

vim.g.home_path=vim.fn.getenv("HOME")
vim.g.wiki_path=vim.fn.getenv("WIKI_PATH")
vim.g.config_path=vim.fn.getenv("VIM_CONFIG_DIR")
vim.g.plug_dir=vim.fn.getenv("VIMPLUGDIR")

local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

local call_requires = function()
  require('var')
  require('options')
  require("packer_plugins")
  require('themes')
  require('custom')
  require('autocommands')
end;

call_requires()
