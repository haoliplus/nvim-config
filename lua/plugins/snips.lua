return {
  {
    'nvimdev/template.nvim',
    dependencies = {{'nvim-telescope/telescope.nvim'}},
    -- this allow us to load this plugin only when we type this command.
    -- But this makes the config ineffect sometimes
    -- cmd = {'Template','TemProject'},
    config = function()
      -- vim.filetype.add ( filename = { ['main.sh'] = 'sh' })
      -- vim.filetype.add ( filename = { ['a.html'] = 'html' })
      require('template').setup({
        temp_dir = vim.g.config_path.."/templates",
        author   = vim.fn.getenv("NICKNAME"), -- your name
        email    = vim.fn.getenv("MAIL"),-- email address
      })
      -- vim.keymap.set('n', '<F10>', ':Template ',  { remap = true})
      require("telescope").load_extension('find_template')
    end,
  },
  -- Using jj to escape
  {'jdhao/better-escape.vim',
    init = function()
      vim.g.better_escape_shortcut = 'jj'
    end
  },
  ---- For ultisnips users.
  {
    'SirVer/ultisnips',
    init = function()
      -- UltiSnips
      vim.g.UltiSnipsSnippetDirectories={vim.g.config_path.."/UltiSnips", vim.g.config_path.."/mysnips"}
      vim.g.ultisnips_python_quoting_style = "double"
    end,
    config = function()
      vim.cmd(
      [[
      autocmd BufNewFile,BufRead python_my.snippets set ft=python
      ]])
    end
  },
}
