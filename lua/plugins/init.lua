#! /usr/bin/env lua
--
-- plugins/init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--

return {
  -- quick commentary
  {'tpope/vim-commentary'},
  -- Utility for other plugin
  {'google/vim-maktaba'},
  -- lsp complete
  {'hrsh7th/nvim-cmp' },
  -- complete sources for nvim-cmp
  {'hrsh7th/cmp-nvim-lsp', dependencies = 'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-buffer', dependencies = 'hrsh7th/nvim-cmp'},
  {'haoliplus/cmp-path', dependencies = 'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-cmdline', dependencies = 'hrsh7th/nvim-cmp'},
  -- {'quangnguyen30192/cmp-nvim-ultisnips'},
  { 'lambdalisue/suda.vim' },
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  {'rcarriga/nvim-notify'},
  {'google/vim-glaive', dependencies = {'google/vim-maktaba' }},
  -- jump between .h/.cc
  -- { 'for': {'c', 'cpp'} }
  {'vim-scripts/a.vim', ft = {"c", "cpp", "cc"} },
  -- syntax highlight
  {'jackguo380/vim-lsp-cxx-highlight'},
  -- Generate doc header and something
  {'vim-scripts/DoxygenToolkit.vim'},
  -- run command :AsyncRun[!]
  {'skywind3000/asyncrun.vim'},
  -- git
  {'tpope/vim-fugitive'},
  {'airblade/vim-gitgutter',
    init = function()
      vim.g.gitgutter_enabled = 0
    end
  },
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
    enabled = false,
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
  {
    'ctrlpvim/ctrlp.vim',
    init = function()
      vim.g.ctrlp_working_path_mode = 0
      vim.g.ctrlp_max_height = 20
      vim.g.ctrlp_custom_ignore = 'node_modules|^.DS_Store|^.git|^.coffee'
      --"""""""""""""""""""""""""""""
      -- => CTRL-P
      --"""""""""""""""""""""""""""""
      vim.g.ctrlp_map = '<c-f>'
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
  ---- community-maintained snippets
  {
    'mileszs/ack.vim',
    init = function()
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
  ---- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {"sindrets/diffview.nvim"}
}
