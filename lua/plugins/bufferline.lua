return {{
    "akinsho/bufferline.nvim",
    enabled=false,
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        -- stylua: ignore
        -- close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        -- right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        -- diagnostics_indicator = function(_, _, diag)
        --   local icons = require("lazyvim.config").icons.diagnostics
        --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        --     .. (diag.warning and icons.Warn .. diag.warning or "")
        --   return vim.trim(ret)
        -- end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function (_, opts)
      require("bufferline").setup(opts)
    end
  },
  {'romgrk/barbar.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    enabled=true,
    opts = {
        -- Set the filetypes which barbar will offset itself for
        sidebar_filetypes = {
          -- Use the default values: {event = 'BufWinLeave', text = nil}
          NvimTree = true,
          -- Or, specify the text used for the offset:
          undotree = {text = 'undotree'},
          -- Or, specify the event which the sidebar executes when leaving:
          ['neo-tree'] = {event = 'BufWipeout'},
          -- Or, specify both
          Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
        },
    },
    config = function(_, opts)
      local map = vim.api.nvim_set_keymap
      local keymap_opts = { noremap = true, silent = true }
      -- Move to previous/next
      map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', keymap_opts)
      map('n', '<A-.>', '<Cmd>BufferNext<CR>', keymap_opts)
      map('n', '<Leader>1', '<Cmd>BufferGoto 1<CR>', keymap_opts)
      map('n', '<Leader>2', '<Cmd>BufferGoto 2<CR>', keymap_opts)
      map('n', '<Leader>3', '<Cmd>BufferGoto 3<CR>', keymap_opts)
      map('n', '<Leader>4', '<Cmd>BufferGoto 4<CR>', keymap_opts)
      map('n', '<Leader>5', '<Cmd>BufferGoto 5<CR>', keymap_opts)
      map('n', '<Leader>6', '<Cmd>BufferGoto 6<CR>', keymap_opts)
      map('n', '<Leader>7', '<Cmd>BufferGoto 7<CR>', keymap_opts)
      map('n', '<Leader>8', '<Cmd>BufferGoto 8<CR>', keymap_opts)
      map('n', '<Leader>9', '<Cmd>BufferGoto 9<CR>', keymap_opts)
      map('n', '<Leader>0', '<Cmd>BufferLast<CR>', keymap_opts)
      -- Close buffer
      map('n', '<Leader>c', '<Cmd>BufferClose<CR>', keymap_opts)
      require("barbar").setup(opts)
    end}
}
-- return {}
