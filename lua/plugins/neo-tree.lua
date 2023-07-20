return {
"nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
  },
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- 'mengelbrecht/lightline-bufferline',
    'akinsho/bufferline.nvim'
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    popup_border_style = "rounded",
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
     buffers = {
       follow_current_file = {enabled=true}, -- This will find and focus the file in the active buffer every
     },
    window = {
      mappings = {
        ["<space>"] = "none",
      },
      width = 25,
    },
    default_component_configs = {
      container = {
        enable_character_fade = true
      },
      indent = {
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        -- expander config, needed for nesting files
        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "*",
        highlight = "NeoTreeFileIcon"
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          -- Change type
          added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = "✖",-- this can only be used in the git_status source
          renamed   = "-",-- this can only be used in the git_status source
          -- Status type
          untracked = "",
          unstaged   = "",
          ignored  = "",
          staged    = "",
          conflict  = "",
        }
      },
    },
  },
  -- config = function()
  config = function(_, opts)
    vim.keymap.set('n', '<F5>', ':NeoTreeShowToggle<CR>', { noremap = true, silent = true })
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define("DiagnosticSignError",
      {text = " ", texthl = "DiagnosticSignError"})
    vim.fn.sign_define("DiagnosticSignWarn",
      {text = " ", texthl = "DiagnosticSignWarn"})
    vim.fn.sign_define("DiagnosticSignInfo",
      {text = " ", texthl = "DiagnosticSignInfo"})
    vim.fn.sign_define("DiagnosticSignHint",
      {text = "", texthl = "DiagnosticSignHint"})
    -- NOTE: this is changed from v1.x, which used the old style of highlight groups
    -- in the form "LspDiagnosticsSignWarning"

    require("neo-tree").setup(opts)

    vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
  end
}
