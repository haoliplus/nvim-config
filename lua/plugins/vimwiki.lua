return {
  {
    "vimwiki/vimwiki",
    -- event = "VeryLazy",
    -- The event that triggers the plugin
    event = "BufEnter *.md",
    -- The keys that trigger the plugin
    keys = { "<leader>ww", "<leader>wt" },
    init = function()
      -- vim.g.vimwiki_map_prefix = '<Leader>i'
      vim.g.vimwiki_list = {
          {path = '~/.notes/', syntax = 'markdown', ext = '.md'}
      }
      -- vim.keymap.set('n', '<Leader>in', '<CMD>lua custom_behavior()<CR>', {noremap=true, silent=true})
    end
  },
}
