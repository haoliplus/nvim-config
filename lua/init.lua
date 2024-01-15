#! /usr/bin/env lua
--
-- init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.g.is_win = (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1)
vim.g.is_linux = (vim.fn.has("unix") == 1 and vim.fn.has("macunix") == 0)
vim.g.is_mac = vim.fn.has("macunix") == 1
vim.g.logging_level = "info"

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

if vim.g.is_linux or vim.g.is_mac then
	if vim.fn.isdirectory(vim.g.config_path) == 0 then
		vim.g.config_path = vim.g.home_path .. "/.config/nvim"
	end
elseif vim.g.is_win then
	if vim.fn.isdirectory(vim.g.config_path) == 0 then
		vim.g.config_path = vim.g.home_path .. "/AppData/Local/nvim"
	end
else
	print("!")
end
vim.opt.rtp:prepend(vim.g.config_path)

-- print(vim.inspect({Hello="world"}))

require("setup")
require("custom_filetype")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath .. "/lua/lazy/init.lua") then
	print("lazy.nvim loading failed.")
	return
end

require("lazy").setup("plugins", {
	performance = {
		rpt = {
			paths = { vim.g.config_path },
		},
	},
})

local function call_requires()
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
