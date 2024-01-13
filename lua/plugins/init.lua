#! /usr/bin/env lua
--
-- plugins/init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--

return {
	-- Generate doc header and something
	{ "vim-scripts/DoxygenToolkit.vim" },
	-- Using jj to escape
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup({
				mapping = { "jk", "jj" },
				timeout = vim.o.timeoutlen,
				clear_empty_lines = true,
				keys = "<Esc>",
			})
		end,
	},
	-- git
	{ "tpope/vim-fugitive" },
	{
		"airblade/vim-gitgutter",
		init = function()
			vim.g.gitgutter_enabled = 0
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				vim.keymap.set("n", "<F9>", ":TroubleToggle<cr>", { silent = true, noremap = true }),
			})
		end,
	},
	---- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
