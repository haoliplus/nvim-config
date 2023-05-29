return {
    "glepnir/lspsaga.nvim",
    lazy = true,
    enabled = true,
    branch = "main",
    event = "LspAttach",
    config = function()
      local default = " "
      require("lspsaga").setup({
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
        }
      })
    end,
    dependencies = {
        {"nvim-tree/nvim-web-devicons"},
        --Please make sure you install markdown and markdown_inline parser
        {"nvim-treesitter/nvim-treesitter"}
    }
}
