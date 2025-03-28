return {
  {
    "ojroques/vim-oscyank",
    branch = "main",
    config = function()
      vim.cmd([[nmap <leader>c <Plug>OSCYankOperator]])
      vim.cmd([[nmap <leader>cc <leader>c_]])
      vim.cmd([[vmap <leader>c <Plug>OSCYankVisual]])
    end,
  },
  -- Utility for other plugin
  { "google/vim-maktaba" },
  { "rcarriga/nvim-notify" },
  -- fuzzy search using c-p
  -- c-b show buffer
  {
    "jlanzarotta/bufexplorer",
    lazy = false,
    keys = {
      -- { "<leader>be", ":BufExplorer<CR>", desc = "Show Buffer" },
      -- { "<leader>bt", ":ToggleBufExplorer<CR>", desc = "Show Buffer" },
      -- { "<leader>bs", ":BufExplorerHorizonSplit<CR>", desc = "Show Buffer" },
      -- { "<leader>bv", ":BufExplorerVerticalSplit<CR>", desc = "Show Buffer" },
      -- <leader>bs:
    },
  },
  {
    "RaafatTurki/hex.nvim",
    config = function()
      require("hex").setup()
    end,
  },
  -- run command :AsyncRun[!]
  { "skywind3000/asyncrun.vim" },
  { "nvim-lua/plenary.nvim" },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
