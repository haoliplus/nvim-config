return {
  {
    "ojroques/vim-oscyank",
    branch = "main",
    keys = {
      { "<leader>c", "<Plug>OSCYankOperator", mode = "n", desc = "Yank with OSCYank" },
      { "<leader>cc", "<leader>c_", mode = "n", desc = "Yank with OSCYank" },
      { "<leader>c", "<Plug>OSCYankVisual", mode = "v", desc = "Yank with OSCYank" },
    },
  },
  -- Utility for other plugin
  { "google/vim-maktaba" },
  { "rcarriga/nvim-notify" },
  -- fuzzy search using c-p
  -- c-b show buffer
  {
    "jlanzarotta/bufexplorer",
    lazy = false,
    enabled = true,
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
    opts = {
      -- function that runs on BufReadPre to determine if it's binary or not
      is_file_binary_pre_read = function()
        -- logic that determines if a buffer contains binary data or not
        -- must return a bool
        return false
      end,
      -- function that runs on BufReadPost to determine if it's binary or not
      is_file_binary_post_read = function()
        -- logic that determines if a buffer contains binary data or not
        -- must return a bool
        return false
      end,
    },
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
