#! /usr/bin/env lua
--
-- plugins/init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--

return {
	-- quick commentary
	{ "tpope/vim-commentary" },
	-- Utility for other plugin
	{ "google/vim-maktaba" },
	{ "lambdalisue/suda.vim" },
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{ "rcarriga/nvim-notify" },
	-- {'google/vim-glaive', dependencies = {'google/vim-maktaba' }},
	-- jump between .h/.cc
	-- { 'for': {'c', 'cpp'} }
	{ "vim-scripts/a.vim", ft = { "c", "cpp", "cc" } },
	-- syntax highlight
	{ "jackguo380/vim-lsp-cxx-highlight" },
	-- Generate doc header and something
	{ "vim-scripts/DoxygenToolkit.vim" },
	-- run command :AsyncRun[!]
	{ "skywind3000/asyncrun.vim" },
	-- git
	{ "tpope/vim-fugitive" },
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
	{
		"airblade/vim-gitgutter",
		init = function()
			vim.g.gitgutter_enabled = 0
		end,
	},
	{ "junegunn/fzf.vim" },
	-- fuzzy search using c-p
	-- c-b show buffer
	{ "jlanzarotta/bufexplorer" },
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				pip = {
					-- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
					upgrade_pip = false,

					-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
					-- and is not recommended.
					--
					-- Example: { "--proxy", "https://proxyserver" }
					install_args = { "-i", "https://pypi.tuna.tsinghua.edu.cn/simple" },
				},
			})
		end,
	},
	-- {
	--   'williamboman/mason-lspconfig.nvim',
	--   dependencies = {
	--     'williamboman/mason.nvim',
	--   },
	--   config = function()
	--     require("mason-lspconfig").setup{
	--       ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "pyright", "nginx-language-server", "typescript-language-server"}
	--     }
	--   end
	-- },
	-- ---- language server protocol
	-- {
	--   'neovim/nvim-lspconfig',
	--   dependencies = {
	--     'williamboman/mason.nvim',
	--     'williamboman/mason-lspconfig.nvim',
	--   },
	-- },

	---- most recently used file
	{
		"vim-scripts/mru.vim",
		enabled = false,
		config = function()
			-- """"""""""""""""""""""""""""""
			-- " => MRU plugin
			-- """"""""""""""""""""""""""""""
			vim.keymap.set("n", "<Leader>f", ":MRU<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<F8>", ":MRU<CR>", { noremap = true, silent = true })
		end,
	},
	---- fuzzy search using c-t
	{
		"junegunn/fzf",
		build = "./install --all",
		config = function()
			-- Fzf
			vim.keymap.set("n", "<F6>", ":Buffers<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<F7>", ":Marks<CR>", { noremap = true, silent = true })
			vim.cmd([[autocmd FileType fzf call feedkeys("i\<Bs>")]])
		end,
	},
	{
		"ctrlpvim/ctrlp.vim",
		init = function()
			vim.g.ctrlp_working_path_mode = 0
			vim.g.ctrlp_max_height = 20
			vim.g.ctrlp_custom_ignore = "node_modules|^.DS_Store|^.git|^.coffee"
			--"""""""""""""""""""""""""""""
			-- => CTRL-P
			--"""""""""""""""""""""""""""""
			vim.g.ctrlp_map = "<c-f>"
		end,
	},
	-- automatically insert/delete parenthesis, brackets, quotes
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	---- motions to surround text with other text
	{
		--- surr*ound_words             ysiw)           (surround_words)
		-- *make strings               ys$"            "make strings"
		-- [delete ar*ound me!]        ds]             delete around me!
		-- remove <b>HTML t*ags</b>    dst             remove HTML tags
		-- 'change quot*es'            cs'"            "change quotes"
		-- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
		-- delete(functi*on calls)     dsf             function calls
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	---- community-maintained snippets
	{
		"mileszs/ack.vim",
		init = function()
			if vim.fn.executable("ag") == 1 then
				vim.g.ackprg = "ag --vimgrep"
				vim.keymap.set("n", "<Leader>a", ":Ack<Space>", { noremap = true, silent = true })
			end
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
	{ "sindrets/diffview.nvim" },
}
