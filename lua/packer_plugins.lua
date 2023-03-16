#! /usr/bin/env lua
--
-- packer_plugins.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.

-- git clone --depth 1 https://github.com/wbthomason/packer.nvim\
--  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Utility for other plugin
  use 'google/vim-maktaba'
  use {
    'google/vim-glaive',
    requires = {
      'google/vim-maktaba'
    },
  }

  -- language server protocol
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    }
  }

  -- jump between .h/.cc
  use {
    'vim-scripts/a.vim', 
    ft = {"c", "cpp", "cc"}
  }-- { 'for': {'c', 'cpp'} }
  -- Format code
  use {
    'google/vim-codefmt',
    requires = {
      'google/vim-glaive',
      'google/vim-maktaba'
    },
    config = function()
      vim.cmd('call glaive#Install()')
      -- FileType
      vim.cmd([[
      autocmd FileType c,cpp,proto,javascript  let b:codefmt_formatter = 'clang-format'
      autocmd FileType bzl let b:codefmt_formatter = 'buildifier'
      autocmd FileType python let b:codefmt_formatter = 'black'
      ]])
      -- Only format manually
      vim.cmd(
      [[
        autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
      ]])
    end
  }
  -- syntax highlight
  use 'jackguo380/vim-lsp-cxx-highlight'
  -- Generate doc header and something
  use 'vim-scripts/DoxygenToolkit.vim'
  -- run command :AsyncRun[!]
  use 'skywind3000/asyncrun.vim'
  -- git 
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  -- Themes
  use 'drewtempelmeyer/palenight.vim'
  -- c-b show buffer
  use 'jlanzarotta/bufexplorer'
  -- quick commentary
  use 'tpope/vim-commentary'
  -- most recently used file
  use 'vim-scripts/mru.vim'
  -- fuzzy search using c-t
  use {
    'junegunn/fzf',
	  run = './install --all',
    config = function() 
      vim.cmd([[autocmd FileType fzf call feedkeys("i\<Bs>")]])
    end
  }
  use 'junegunn/fzf.vim'
  -- fuzzy search using c-p
  use {'ctrlpvim/ctrlp.vim',
    setup = function() 
    end
  }
  -- file template
  use {'tibabit/vim-templates',
    setup = function()
      -- vim-templates
        vim.g.tmpl_author_email = vim.fn.getenv("MAIL")
        local cur_dir=vim.g.config_path.."/mytemplates"
        vim.g.tmpl_search_paths = {cur_dir}
    end,
    config = function() 
      vim.cmd(
      [[
      autocmd BufNewFile,BufRead py.template set ft=python
      autocmd BufNewFile,BufRead *.yaml.template set ft=yaml
      autocmd BufNewFile,BufRead sh.template set ft=sh
      ]])
    end
  }
  -- Using jj to escape
  use 'jdhao/better-escape.vim'
  -- status bar
  use {'itchyny/lightline.vim',
    setup = function() 
    end
  }
  -- show indent line
  use {'Yggdroot/indentLine',
    setup = function() 
    end
  }
    -- Better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  -- automatically insert/delete parenthesis, brackets, quotes
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end }

  -- motions to surround text with other text
  use { 'kylechui/nvim-surround', config = function() require('nvim-surround').setup() end }

  -- lsp complete
  use 'hrsh7th/nvim-cmp'
  -- complete sources for nvim-cmp
  use { 'hrsh7th/cmp-nvim-lsp', requires = 'hrsh7th/nvim-cmp'}
  use { 'hrsh7th/cmp-buffer', requires = 'hrsh7th/nvim-cmp'}
  use { 'haoliplus/cmp-path', requires = 'hrsh7th/nvim-cmp'}
  use { 'hrsh7th/cmp-cmdline', requires = 'hrsh7th/nvim-cmp'}

  -- For ultisnips users.
  use {'SirVer/ultisnips',
    setup = function() 
    end,
    config = function() 
      vim.cmd(
        [[
        autocmd BufNewFile,BufRead python_my.snippets set ft=python
        ]])
    end
  } 
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  -- community-maintained snippets
  use {'mileszs/ack.vim',
    setup = function() 
      if vim.fn.executable('ag') == 1 then
      end
    end
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {'nvim-tree/nvim-web-devicons'},
    config = function() 
      vim.keymap.set('n', '<F5>', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
    end
  }
  use {
    'haoliplus/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {
          path= vim.g.wiki_path .. '/text/',
          index='Home',
          path_html= vim.g.wiki_path..'/html/',
          syntax= 'markdown',
          inner_link_syntax= 'mediawiki',
          ext= '.md',
          auto_diary_index= 1,
          diary_rel_path= 'summary/diary/',
          auto_generate_links= 1,
          template_path= vim.g.wiki_path .. '/templates/',
          template_default= 'def_template',
          template_ext= '.html'
         }
       }
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown',
      }
      vim.g.vimwiki_hl_headers = 1
      vim.g.vimwiki_global_ext = 0
      vim.cmd([[
        autocmd BufNewFile,BufRead */vimwiki/**.md :autocmd TextChanged,TextChangedI <buffer> silent write
      ]])
    end
  }
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
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
  }
  use {'romgrk/barbar.nvim', requires = 'nvim-tree/nvim-web-devicons',
    config = function() 
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      -- Move to previous/next
      -- map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      -- map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
      -- Re-order to previous/next
      -- map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
      -- map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
      -- Goto buffer in position...
      map('n', '<Leader>1', '<Cmd>BufferGoto 1<CR>', opts)
      map('n', '<Leader>2', '<Cmd>BufferGoto 2<CR>', opts)
      map('n', '<Leader>3', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '<Leader>4', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '<Leader>5', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '<Leader>6', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '<Leader>7', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '<Leader>8', '<Cmd>BufferGoto 8<CR>', opts)
      map('n', '<Leader>9', '<Cmd>BufferGoto 9<CR>', opts)
      map('n', '<Leader>0', '<Cmd>BufferLast<CR>', opts)
      -- Pin/unpin buffer
      map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
      -- Close buffer
      map('n', '<Leader>c', '<Cmd>BufferClose<CR>', opts)
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseAllButCurrentOrPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight
      -- Magic buffer-picking mode
      -- map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
      -- Sort automatically by...
      -- map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
      -- map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
      -- map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
      -- map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
    end
  } -- barbar.nvim
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup({animation=false})
    end
  } -- bufferline.nvim
end)
