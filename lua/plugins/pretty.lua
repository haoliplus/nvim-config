return {
	-- Themes
	{ "drewtempelmeyer/palenight.vim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	---- show indent line
	{
		"Yggdroot/indentLine",
		enabled = false,
		init = function()
			-- Indent Line
			vim.g.indentLine_bufNameExclude = { "_.*", "NERD_tree.*", "*.wiki", "dashboard" }
			vim.g.indentLine_fileTypeExclude = { "vimwiki", "dashboard" }
			vim.g.indentLine_bufTypeExclude = { "help", "terminal", "vimwiki", "dashboard" }
			vim.g.indentLine_color_term = 239
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")

			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }

			require("ibl").setup({
				scope = {
					highlight = highlight,
				},
				-- show_current_context = true,
				-- show_current_context_start = false,
				-- show_end_of_line = true,
			})

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

			require("ibl").overwrite({
				exclude = { filetypes = { "help", "terminal", "vimwiki", "dashboard" } },
			})
		end,
		-- init = function()
		--     -- vim.cmd([[highlight IndentBlanklineContextStart guisp=#00FF00 gui=italic cterm=italic]])
		--     vim.g.indent_blankline_filetype_exclude = {'help', 'help', 'terminal', 'vimwiki', 'dashboard'}
		-- end,
		-- config = function()
		--   require("indent_blankline").setup {
		--       -- for example, context is off by default, use this to turn it on
		--       show_current_context = true,
		--       show_current_context_start = false,
		--       show_end_of_line = true,
		--   }
		-- end
	},
}
