return {
  { -- install formatters, linters, etc.
    "mason-org/mason.nvim",
    opts = {
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
    },
  },
}
