return {
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
	-- jump between .h/.cc
	-- { 'for': {'c', 'cpp'} }
	{ "vim-scripts/a.vim", ft = { "c", "cpp", "cc", "cuda" } },
	---- fuzzy search using c-t
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
	--{
	--	"ctrlpvim/ctrlp.vim",
	--	init = function()
	--		vim.g.ctrlp_working_path_mode = 0
	--		vim.g.ctrlp_max_height = 20
	--		vim.g.ctrlp_custom_ignore = "node_modules|^.DS_Store|^.git|^.coffee"
	--		--"""""""""""""""""""""""""""""
	--		-- => CTRL-P
	--		--"""""""""""""""""""""""""""""
	--		vim.g.ctrlp_map = "<c-f>"
	--	end,
	--},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                            , branch = '0.1.x',
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("telescope").setup({
				defaults = {
					-- Default configuration for telescope goes here:
					-- config_key = value,
					mappings = {
						i = {
							-- map actions.which_key to <C-h> (default: <C-/>)
							-- actions.which_key shows the mappings for your picker,
							-- e.g. git_{create, delete, ...}_branch for the git_branches picker
							["<C-h>"] = "which_key",
						},
					},
				},
				pickers = {
					-- Default configuration for builtin pickers goes here:
					-- picker_name = {
					--   picker_config_key = value,
					--   ...
					-- }
					-- Now the picker_config_key will be applied every time you call this
					-- builtin picker
				},
				extensions = {
					-- Your extension configuration goes here:
					-- extension_name = {
					--   extension_config_key = value,
					-- }
					-- find_template = {
					-- },
					-- please take a look at the readme of the extension you want to configure
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})
			require("telescope").load_extension("fzf")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
			vim.keymap.set("n", "<c-f>", builtin.find_files, {})
	--		vim.g.ctrlp_map = "<c-f>"
		end,
	},
}
