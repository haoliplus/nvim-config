return {
  -- Themes
  {'drewtempelmeyer/palenight.vim'},
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  ---- show indent line
  {
    'Yggdroot/indentLine',
    enabled = false,
    init = function()
      -- Indent Line
      vim.g.indentLine_bufNameExclude = {'_.*', 'NERD_tree.*', '*.wiki', 'dashboard'}
      vim.g.indentLine_fileTypeExclude = {'vimwiki', 'dashboard'}
      vim.g.indentLine_bufTypeExclude = {'help', 'terminal', 'vimwiki', 'dashboard'}
      vim.g.indentLine_color_term = 239
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
        vim.g.indent_blankline_filetype_exclude = {'help', 'help', 'terminal', 'vimwiki', 'dashboard'}
    end,
    config = function()
      require("indent_blankline").setup {
          -- for example, context is off by default, use this to turn it on
          show_current_context = true,
          show_current_context_start = true,
          show_end_of_line = true,
      }
    end
  },
}
