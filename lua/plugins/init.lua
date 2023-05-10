#! /usr/bin/env lua
--
-- plugins/init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--

return {
  -- Themes
  {'drewtempelmeyer/palenight.vim'},
  -- quick commentary
  {'tpope/vim-commentary'},
  -- Utility for other plugin
  {'google/vim-maktaba'},
  -- lsp complete
  { 'hrsh7th/nvim-cmp' },
  -- complete sources for nvim-cmp
  { 'hrsh7th/cmp-nvim-lsp', dependencies = 'hrsh7th/nvim-cmp'},
  { 'hrsh7th/cmp-buffer', dependencies = 'hrsh7th/nvim-cmp'},
  { 'haoliplus/cmp-path', dependencies = 'hrsh7th/nvim-cmp'},
  { 'hrsh7th/cmp-cmdline', dependencies = 'hrsh7th/nvim-cmp'},
  -- {'quangnguyen30192/cmp-nvim-ultisnips'},
  { 'lambdalisue/suda.vim' },
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  {'rcarriga/nvim-notify'},
  { 'google/vim-glaive', dependencies = {'google/vim-maktaba' }},
  -- jump between .h/.cc
  -- { 'for': {'c', 'cpp'} }
  { 'vim-scripts/a.vim', ft = {"c", "cpp", "cc"} },
  -- syntax highlight
  {'jackguo380/vim-lsp-cxx-highlight'},
  -- Generate doc header and something
  {'vim-scripts/DoxygenToolkit.vim'},
  -- run command :AsyncRun[!]
  {'skywind3000/asyncrun.vim'},
  -- git
  {'tpope/vim-fugitive'},
  {'airblade/vim-gitgutter'},
  {'junegunn/fzf.vim'},
  -- fuzzy search using c-p
  -- c-b show buffer
  {'jlanzarotta/bufexplorer'},
  {
      'williamboman/mason-lspconfig.nvim',
      dependencies = {
        'williamboman/mason.nvim',
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup{
          ensure_installed = { "lua_ls", "rust_analyzer" }
        }
      end
  },
  ---- language server protocol
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },

  ---- most recently used file
  {
    'vim-scripts/mru.vim',
    config = function ()
      -- """"""""""""""""""""""""""""""
      -- " => MRU plugin
      -- """"""""""""""""""""""""""""""
      vim.keymap.set('n', '<Leader>f', ':MRU<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<F8>', ':MRU<CR>', { noremap = true, silent = true })
    end
  },
  ---- fuzzy search using c-t
  {
    'junegunn/fzf',
    build = './install --all',
    config = function()
      -- Fzf
      vim.keymap.set('n', '<F6>', ':Buffers<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<F7>', ':Marks<CR>', { noremap = true, silent = true })
      vim.cmd([[autocmd FileType fzf call feedkeys("i\<Bs>")]])
    end
  },
  {'ctrlpvim/ctrlp.vim',
    setup = function()
      vim.g.ctrlp_working_path_mode = 0
      vim.g.ctrlp_max_height = 20
      vim.g.ctrlp_custom_ignore = 'node_modules|^.DS_Store|^.git|^.coffee'
      --"""""""""""""""""""""""""""""
      -- => CTRL-P
      --"""""""""""""""""""""""""""""
      vim.g.ctrlp_map = '<c-f>'
    end
  },
  {'nvimdev/template.nvim',
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
  end},
  -- Using jj to escape
  {'jdhao/better-escape.vim',
    setup = function()
      vim.g.better_escape_shortcut = 'jj'
    end
  },
  -- automatically insert/delete parenthesis, brackets, quotes
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  },
  ---- motions to surround text with other text
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  },

  ---- For ultisnips users.
  {'SirVer/ultisnips',
    setup = function()
      -- UltiSnips
      vim.g.UltiSnipsSnippetDirectories={"UltiSnips", "mysnips"}
      vim.g.ultisnips_python_quoting_style = "double"
    end,
    config = function()
      vim.cmd(
        [[
        autocmd BufNewFile,BufRead python_my.snippets set ft=python
        ]])
    end
  },
  ---- community-maintained snippets
  {'mileszs/ack.vim',
    setup = function()
      if vim.fn.executable('ag') == 1 then
        vim.g.ackprg = 'ag --vimgrep'
        vim.keymap.set('n', '<Leader>a', ':Ack<Space>', { noremap = true, silent = true })
      end
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        vim.keymap.set("n", "<F9>", ":TroubleToggle<cr>",
          {silent = true, noremap = true}
        )
      }
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  ---- install without yarn or npm
  {
      "iamcco/markdown-preview.nvim",
      build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "glepnir/lspsaga.nvim",
    lazy = true,
    enabled = true,
    branch = "main",
    event = "LspAttach",
    config = function()
      local default = ""
      require("lspsaga").setup({
        ui = {
          kind = {
            ["String"] = { default, 'String' },
            ["Number"] = { default, 'Number' },
            ["Array"] = { default, 'Type' },
            ["Null"] = { default, 'Constant' },
            ["Text"] = { default, 'String' },
            ["Function"] = { default, 'Function' },
            ["Unit"] = { default, 'Number' },
            ["Folder"] = { " ", "@comment" },
          }
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
  },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        config = {
          packages = { enable = true }, -- show how many plugins neovim loaded
          mru = { limit = 10, icon = '* ', label = 'Recent Files', },
          footer = {"hello"}, -- footer
          -- limit how many projects list, action when you press key or enter it will run this action.
          -- action can be a functino type, e.g.
          -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
          project = { enable = true, limit = 8, icon = '- ', label = 'Recent Project' },
        },
      }
    end,
    dependencies = {'nvim-tree/nvim-web-devicons'}
  },
  ---- Format code
} -- packer.setup
