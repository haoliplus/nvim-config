return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      -- { "\\", "<cmd>Neotree reveal<cr>", mode = "n", noremap = true, silent = true, desc = "exit" },
      -- {
      --   "<F5>",
      --   function()
      --     require("neo-tree.command").execute({ toggle = true, position = "left", dir = vim.uv.cwd() })
      --   end,
      --   desc = "Explorer NeoTree (cwd)",
      -- },
      { "<leader>ef", ":Neotree toggle left<CR>", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>eb", ":Neotree buffers<CR>", desc = "Explorer Buffers (root dir)", remap = true },
      { "<leader>eg", ":Neotree git_status<CR>", desc = "Explorer NeoTree (cwd)", remap = true },
      { "<leader>ed", ":Neotree document_symbols<CR>", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- 'mengelbrecht/lightline-bufferline',
      "akinsho/bufferline.nvim",
      -- "3rd/image.nvim",
      "folke/edgy.nvim"
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.uv.fs_stat(tostring(vim.fn.argv(0)))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
      -- NOTE: this is changed from v1.x, which used the old style of highlight groups
      -- in the form "LspDiagnosticsSignWarning"
    end,
    opts = {
      popup_border_style = "rounded",
      animate = {enabled = false},
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      source_selector = {
        winbar = false,
        statusline = false,
        sources = {
          { source = "filesystem" },
          { source = "git_status" },
          { source = "buffers" },
          { source = "document_symbols" },
        },
      },
      -- open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" }, -- 此处会造车edgy产生问题，但不清楚原因
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
          hide_gitignored = false,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            "node_modules",
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
            "*.pyc",
            "bazel-*",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            ".gitignored",
            ".gitignore",
            ".dotfiles",
            ".zshrc",
            ".zshenv",
            ".config",
            ".kube",
            ".ssh",
          },
          always_show_by_pattern = { -- uses glob style patterns
            ".env*",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            ".DS_Store",
            "thumbs.db",
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
      },
      buffers = {
        follow_current_file = { enabled = true }, -- This will find and focus the file in the active buffer every
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["e"] = nil,
        },
        width = 30,
        auto_expand = true,
      },
      default_component_configs = {
        container = {
          enable_character_fade = true,
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
          -- default = "*",
          default = "",
          highlight = "NeoTreeFileIcon",
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
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "x", -- this can only be used in the git_status source
            renamed = "-", -- this can only be used in the git_status source
            -- Status type
            untracked = "?",
            unstaged = "",
            ignored = "",
            staged = "",
            conflict = "",
          },
        },
      },
    }, -- opts
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3 -- only show statusline in the last window
      -- vim.opt.showtabline = 0 -- hide tabline
      vim.opt.splitkeep = "screen" -- enable splitscreen mode
    end,
    enabled = false,
    opts = {
      bottom = {
      --   -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      --   {
      --     ft = "toggleterm",
      --     size = { height = 0.4 },
      --     -- exclude floating windows
      --     filter = function(buf, win)
      --       return vim.api.nvim_win_get_config(win).relative == ""
      --     end,
      --   },
      --   {
      --     ft = "lazyterm",
      --     title = "LazyTerm",
      --     size = { height = 0.4 },
      --     filter = function(buf)
      --       return not vim.b[buf].lazyterm_cmd
      --     end,
      --   },
        { ft = "qf", title = "QuickFix" },
      --   {
      --     ft = "help",
      --     size = { height = 20 },
      --     -- only show help buffers
      --     filter = function(buf)
      --       return vim.bo[buf].buftype == "help"
      --     end,
      --   },
      --   { ft = "spectre_panel", size = { height = 0.4 } },
        "Trouble",
      },
      left = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { height = 0.5 },
        },
        {
          title = "Neo-Tree Buffers",
          ft = "neo-tree",
          filter = function(buf)
            -- return vim.b[buf].neo_tree_source == "buffers"
            return vim.b[buf].neo_tree_source == "buffers" and vim.b[buf].neo_tree_position ~= "float"
          end,
          pinned = true,
          collapsed = false, -- show window as closed/collapsed on start
          open = "Neotree position=top buffers",
          size = { height = 0.4 },
        },
        -- {
        --   title = "Neo-Tree Git",
        --   ft = "neo-tree",
        --   filter = function(buf)
        --     return vim.b[buf].neo_tree_source == "git_status"
        --   end,
        --   pinned = true,
        --   collapsed = true, -- show window as closed/collapsed on start
        --   open = "Neotree position=right git_status",
        -- },
        {
          title = function()
            local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
            return vim.fn.fnamemodify(buf_name, ":t")
          end,
          ft = "Outline",
          pinned = true,
          open = "SymbolsOutlineOpen",
        },
        -- any other neo-tree windows
        "neo-tree",
      },
    },
  }, --edgy
  {
    "folke/trouble.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons", "folke/edgy.nvim"},
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      { "<F9>", "<cmd>Trouble diagnostics<cr>", mode = "n", silent = true, noremap = true, desc = "TroubleToggle" },
    },
  },
}
