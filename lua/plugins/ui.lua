return {
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    dependencies = "nvim-tree/nvim-web-devicons",
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
    config = function(_, opts)
      local map = vim.api.nvim_set_keymap
      -- Move to previous/next
      map(
        "n",
        "<M-,>",
        "<Cmd>BufferLineMovePrev<CR>",
        { noremap = true, silent = true, desc = "Move to previous buffer" }
      )
      map("n", "<M-.>", "<Cmd>BufferLineGoToBuffer<CR>", { noremap = true, silent = true, desc = "Move to buffer" })
      map(
        "n",
        "<Tab><Tab>",
        "<Cmd>BufferLineCycleNext<CR>",
        { noremap = true, silent = true, desc = "Move to next buffer" }
      )
      map(
        "n",
        "<Leader>[",
        "<Cmd>BufferLineCyclePrev<CR>",
        { noremap = true, silent = true, desc = "Move to previous buffer" }
      )
      map(
        "n",
        "<Leader>]",
        "<Cmd>BufferLineCycleNext<CR>",
        { noremap = true, silent = true, desc = "Move to next buffer" }
      )
      map(
        "n",
        "<Leader>1",
        "<Cmd>BufferLineGoToBuffer 1<CR>",
        { noremap = true, silent = true, desc = "Move to buffer 1" }
      )
      map(
        "n",
        "<Leader>2",
        "<Cmd>BufferLineGoToBuffer 2<CR>",
        { noremap = true, silent = true, desc = "Move to buffer 2" }
      )
      map(
        "n",
        "<Leader>3",
        "<Cmd>BufferLineGoToBuffer 3<CR>",
        { noremap = true, silent = true, desc = "Move to buffer 3" }
      )
      map(
        "n",
        "<Leader>4",
        "<Cmd>BufferLineGoToBuffer 4<CR>",
        { noremap = true, silent = true, desc = "Move to buffer 4" }
      )
      map(
        "n",
        "<Leader>5",
        "<Cmd>BufferLineGoToBuffer 5<CR>",
        { noremap = true, silent = true, desc = "Move to buffer 5" }
      )
      map(
        "n",
        "<Leader>6",
        "<Cmd>BufferLineGoToBuffer 6<CR>",
        { noremap = true, silent = true, desc = "Move to buffer 6" }
      )
      map(
        "n",
        "<Leader>7",
        "<Cmd>BufferLineGoToBuffer 7<CR>",
        { noremap = true, silent = true, desc = "Move to buffer 7" }
      )
      map(
        "n",
        "<Leader>8",
        "<Cmd>BufferLineGoToBuffer 8<CR>",
        { noremap = true, silent = true, desc = "Move to buffer 8" }
      )
      map(
        "n",
        "<Leader>9",
        "<Cmd>BufferLineGoToBuffer 9<CR>",
        { noremap = true, silent = true, desc = "Move to buffer 9" }
      )
      -- Close buffer
      map("n", "<Leader>c", "<Cmd>BufferLinePickClose<CR>", { noremap = true, silent = true, desc = "Close buffer" })

      require("bufferline").setup(opts)
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    enabled = true,
    branch = "main",
    event = "LspAttach",
    -- ft = {'c','cpp', 'lua', 'rust', 'go'},
    config = function()
      -- local default = " "
      require("lspsaga").setup({
        lightbulb = {
          enable = false,
          enable_in_insert = true,
          sign = false, -- false: only show bulb at the end of line
          sign_priority = 40,
          virtual_text = true,
        },
        ui = {
          -- kind = {
          --   ["String"] = { default, 'String' },
          --   ["Number"] = { default, 'Number' },
          --   ["Array"] = { default, 'Type' },
          --   ["Null"] = { default, 'Constant' },
          --   ["Text"] = { default, 'String' },
          --   ["Function"] = { default, 'Function' },
          --   ["Unit"] = { default, 'Number' },
          --   ["Folder"] = { " ", "@comment" },
          -- }
          -- kind = {
          --   [1] = { 'File', ' ', 'Tag' },
          --   [2] = { 'Module', ' ', 'Exception' },
          --   [3] = { 'Namespace', ' ', 'Include' },
          --   [4] = { 'Package', ' ', 'Label' },
          --   [5] = { 'Class', ' ', 'Include' },
          --   [6] = { 'Method', ' ', 'Function' },
          --   [7] = { 'Property', ' ', '@property' },
          --   [8] = { 'Field', ' ', '@field' },
          --   [9] = { 'Constructor', ' ', '@constructor' },
          --   [10] = { 'Enum', ' ', '@number' },
          --   [11] = { 'Interface', ' ', 'Type' },
          --   [12] = { 'Function', '󰊕', 'Function' },
          --   [13] = { 'Variable', ' ', '@variable' },
          --   [14] = { 'Constant', ' ', 'Constant' },
          --   [15] = { 'String', '󰅳 ', 'String' },
          --   [16] = { 'Number', '󰎠 ', 'Number' },
          --   [17] = { 'Boolean', ' ', 'Boolean' },
          --   [18] = { 'Array', '󰅨 ', 'Type' },
          --   [19] = { 'Object', ' ', 'Type' },
          --   [20] = { 'Key', ' ', 'Constant' },
          --   [21] = { 'Null', '󰟢 ', 'Constant' },
          --   [22] = { 'EnumMember', ' ', 'Number' },
          --   [23] = { 'Struct', ' ', 'Type' },
          --   [24] = { 'Event', ' ', 'Constant' },
          --   [25] = { 'Operator', ' ', 'Operator' },
          --   [26] = { 'TypeParameter', ' ', 'Type' },
          --   -- ccls
          --   [252] = { 'TypeAlias', ' ', 'Type' },
          --   [253] = { 'Parameter', ' ', '@parameter' },
          --   [254] = { 'StaticMethod', ' ', 'Function' },
          --   [255] = { 'Macro', ' ', 'Macro' },
          --   -- for completion sb microsoft!!!
          --   [300] = { 'Text', '󰭷 ', 'String' },
          --   [301] = { 'Snippet', ' ', '@variable' },
          --   [302] = { 'Folder', ' ', 'Title' },
          --   [303] = { 'Unit', '󰊱 ', 'Number' },
          --   [304] = { 'Value', ' ', '@variable' },
          -- }
        },
      })
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- 'AndreM222/copilot-lualine',
    },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "copilot", "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local vim_version_major = vim.version().major
      local vim_version_minor = vim.version().minor
      local vim_version_patch = vim.version().patch
      local vim_version_build = vim.version().build
      local version = vim_version_major
        .. "."
        .. vim_version_minor
        .. "."
        .. vim_version_patch
        .. "+"
        .. vim_version_build
      require("dashboard").setup({
        config = {
          week_header = {
            enable = true,
            concat = "vim:" .. version,
            append = { "Hello" },
          },
          packages = { enable = true }, -- show how many plugins neovim loaded
          mru = { limit = 10, icon = "* ", label = "Recent Files" },
          footer = { "hello: " .. version }, -- footer
          -- limit how many projects list, action when you press key or enter it will run this action.
          -- action can be a functino type, e.g.
          -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
          project = { enable = true, limit = 8, icon = "- ", label = "Recent Project" },
          shortcut = {
            { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Files",
              group = "Label",
              action = "Telescope find_files",
              key = "f",
            },
            {
              desc = " Recent Files",
              group = "Files",
              action = "Telescope oldfiles",
              key = "a",
            },
          },
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      {
        "<F5>",
        function()
          require("neo-tree.command").execute({ toggle = true, position = "left", dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>fe", ":NeoTreeFloatToggle<CR>", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>e", ":Neotree toggle left<CR>", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", ":Neotree toggle float git_status<CR>", desc = "Explorer NeoTree (cwd)", remap = true },
      -- { "<leader>B", ":Neotree toggle float buffers<CR>", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- 'mengelbrecht/lightline-bufferline',
      "akinsho/bufferline.nvim",
      -- "3rd/image.nvim",
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
    end,
    opts = {
      popup_border_style = "rounded",
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
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
        },
        width = 40,
        auto_expand = true,
      },
      source_selector = {
        winbar = true,
        statusline = false,
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
    },
    -- config = function()
    config = function(_, opts)
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
      -- NOTE: this is changed from v1.x, which used the old style of highlight groups
      -- in the form "LspDiagnosticsSignWarning"

      require("neo-tree").setup(opts)

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end,
  },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  {
    "folke/noice.nvim",
    enabled = true,
    config = function()
      require("noice").setup({
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
          { -- 消息内容包含 "textDocument" 的通知, 跳过不显示:
            filter = {
              event = "notify",
              find = "textDocument",
            },
            opts = { skip = true },
          },
          { -- 消息内容包含 "textDocument" 的通知, 跳过不显示:
            filter = {
              event = "notify",
              find = "Copilot",
            },
            opts = { skip = true },
          },
        }, -- routes
        -- add any options here
        lsp = {
          progress = {
            enabled = true,
            -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
            -- See the section on formatting for more details on how to customize.
            --- @type NoiceFormat|string
            format = "lsp_progress",
            --- @type NoiceFormat|string
            format_done = "lsp_progress_done",
            throttle = 1000 / 30, -- frequency to update lsp progress message
            view = "mini",
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        }, -- lsp
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        }, -- presets
        notify = {
          -- Noice can be used as `vim.notify` so you can route any notification like other messages
          -- Notification messages have their level and other properties set.
          -- event is always "notify" and kind can be any log level as a string
          -- The default routes will forward notifications to nvim-notify
          -- Benefit of using Noice for this is the routing and consistent history view
          enabled = true,
          view = "notify",
        },
        cmdline = {
          view = "cmdline_popup",
          enabled = true,
          format = {
            -- title: set to anything or empty string to hide
            title = { "cmdline" },
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = {
              pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
              icon = "",
              lang = "lua",
            },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
            input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
          },
        }, -- cmdline
        messages = {
          -- NOTE: If you enable messages, then the cmdline is enabled automatically.
          -- This is a current Neovim limitation.
          enabled = true, -- enables the Noice messages UI
          view = "notify", -- default view for messages
          view_error = "notify", -- view for errors
          view_warn = "notify", -- view for warnings
          view_history = "messages", -- view for :messages
          view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
          format = {
            title = { "messages" },
          },
        }, -- messages
        popupmenu = {
          enabled = true, -- enables the Noice popupmenu UI
          ---@type 'nui'|'cmp'
          backend = "nui", -- backend to use to show regular cmdline completions
          ---@type NoicePopupmenuItemKind|false
          -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
          kind_icons = {}, -- set to `false` to disable icons
          format = {
            title = { "popupmenu" },
          },
        },
        -- default options for require('noice').redirect
        -- see the section on Command Redirection
        ---@type NoiceRouteConfig
        -- redirect = {
        --   view = "popup",
        --   filter = { event = "msg_show" },
        -- },
      })
      vim.keymap.set('n', '<Esc>', ':NoiceDismiss<CR>', { noremap = true, silent = true })
    end,
  },
}
-- return {}
