---@diagnostic disable: undefined-doc-name
-- stylua: ignore

return {
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<M-,>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move to previous buffer" },
      { "<M-.>", "<Cmd>BufferLineGoToBuffer<CR>", desc = "Move to buffer" },
      { "<Tab><Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Move to next buffer" },
      { "<Leader>[", "<Cmd>BufferLineCyclePrev<CR>", desc = "Move to previous buffer" },
      { "<Leader>]", "<Cmd>BufferLineCycleNext<CR>", desc = "Move to next buffer" },
      { "<Leader>c", "<Cmd>BufferLinePickClose<CR>", desc = "Close buffer" },
      { "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Move to buffer 1" },
      { "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Move to buffer 2" },
      { "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Move to buffer 3" },
      { "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Move to buffer 4" },
      { "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Move to buffer 5" },
      { "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Move to buffer 6" },
      { "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Move to buffer 7" },
      { "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Move to buffer 8" },
      { "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Move to buffer 9" },
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
  },
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    enabled = true,
    branch = "main",
    event = "LspAttach",
    -- ft = {'c','cpp', 'lua', 'rust', 'go'},
    opts = {
      lightbulb = { enable = false,
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
    },
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
    opts = {
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
    },
  },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
}
