return {
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = false,
    -- version = "v1.*",
    dependencies = {
      "mason-org/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- "tree-sitter-cli",
          -- "lua_ls",
          -- "rust_analyzer",
          -- "clangd",
          "pyright",
          "ts_ls", -- "typescript-language-server",
          "bashls",
          "ruff",
          -- "omnisharp",
          -- "gopls",
          -- "ast_grep",
          -- "black",
          -- "bash-language-server",
          --"prettier"
        },
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({
        -- npm = {
        --   install_args = { "--registry", "https://registry.npmmirror.com" }
        -- },
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
