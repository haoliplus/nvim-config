return {
	{
		"williamboman/mason-lspconfig.nvim",
		enabled = true,
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"clangd",
					"pyright",
					"tsserver",
					"bashls",
					"ruff_lsp",
          "gopls",
          "ast_grep",
          -- "black",
          -- "bash-language-server",
          --"prettier"
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				pip = {
					-- Whether to upgrade pip to the latest version 
          -- in the virtual environment before installing packages.
					upgrade_pip = true,

					-- These args will be added to `pip install` calls. 
          -- Note that setting extra args might impact intended behavior
					-- and is not recommended.
					--
					-- Example: { "--proxy", "https://proxyserver" }
					install_args = { "-i", "https://pypi.tuna.tsinghua.edu.cn/simple" },
				},
			})
		end,
	},
}
