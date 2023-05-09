#! /usr/bin/env lua
--
-- plugins/init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim\
--  ~/.local/share/nvim/site/pack/packer/start/packer.nvim


-- use {
--   'myusername/example',        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded. The code is ran even if
--                                -- the plugin is waiting for other conditions (ft, cond...) to be met.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--                                -- requiring a string which matches one of these patterns, the plugin will be loaded.
-- }

local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

local keymap = vim.keymap
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
  use {
      'williamboman/mason.nvim',
      run = ":MasonUpdate",
      config = function() 
        require("mason").setup()
      end
  }

  -- language server protocol
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
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
  use {
    'vim-scripts/mru.vim',
    config = function ()
      -- """"""""""""""""""""""""""""""
      -- " => MRU plugin
      -- """"""""""""""""""""""""""""""
      vim.keymap.set('n', '<Leader>f', ':MRU<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<F8>', ':MRU<CR>', { noremap = true, silent = true })
    end
  }
  -- fuzzy search using c-t
  use {
    'junegunn/fzf',
    run = './install --all',
    config = function()
      -- Fzf
      vim.keymap.set('n', '<F6>', ':Buffers<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<F7>', ':Marks<CR>', { noremap = true, silent = true })
      vim.cmd([[autocmd FileType fzf call feedkeys("i\<Bs>")]])
    end
  }
  use 'junegunn/fzf.vim'
  -- fuzzy search using c-p
  use {'ctrlpvim/ctrlp.vim',
    setup = function()
      vim.g.ctrlp_working_path_mode = 0
      vim.g.ctrlp_max_height = 20
      vim.g.ctrlp_custom_ignore = 'node_modules|^.DS_Store|^.git|^.coffee'
      --"""""""""""""""""""""""""""""
      -- => CTRL-P
      --"""""""""""""""""""""""""""""
      vim.g.ctrlp_map = '<c-f>'
    end
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function() 
      require('telescope').setup{
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key"
            }
          }
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
            -- find_template = {
            -- },
          -- please take a look at the readme of the extension you want to configure
        }
      }
    end
  }
  use {'nvimdev/template.nvim', 
    requires = {{'nvim-telescope/telescope.nvim'}},
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
  end}
  -- Using jj to escape
  use {'jdhao/better-escape.vim',
    setup = function()
      vim.g.better_escape_shortcut = 'jj'
    end
  }
  -- status bar
  use {'itchyny/lightline.vim',
    requires = {
      'mengelbrecht/lightline-bufferline',
      'akinsho/bufferline.nvim'
    },
    setup = function()
      vim.g.lightline = {
        colorscheme = 'one',
        active = {
          left = {
            {'filename', 'gitbranch', 'mode'},
            {'readonly', 'paste', 'modified'}
          },
          right= {
            {'lineinfo', 'percent' },
            -- 'fileformat', 'fileencoding',
            {'filetype', 'charvaluehex' }
          }
        },
        component_function = {
          gitbranch = 'FugitiveHead',
        },
        component_expand = {
          buffers = 'lightline#bufferline#buffers'
        },
        component_type = {
          buffers = 'tabsel'
        }
      }
    end
  }
  -- show indent line
  use {'Yggdroot/indentLine',
    setup = function()
      -- Indent Line
      vim.g.indentLine_bufNameExclude = {'_.*', 'NERD_tree.*', '*.wiki'}
      vim.g.indentLine_fileTypeExclude = {'vimwiki'}
      vim.g.indentLine_bufTypeExclude = {'help', 'terminal', 'vimwiki'}
      vim.g.indentLine_color_term = 239
    end
  }
  -- Better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    disable = true,
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "c", "lua", "vim", "help", "query" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "javascript" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = false,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = { "c", "rust" },
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  }
  -- automatically insert/delete parenthesis, brackets, quotes
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }
  -- motions to surround text with other text
  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  }
  -- lsp complete
  use {
    'hrsh7th/nvim-cmp',
  }
  -- complete sources for nvim-cmp
  use { 'hrsh7th/cmp-nvim-lsp', requires = 'hrsh7th/nvim-cmp'}
  use { 'hrsh7th/cmp-buffer', requires = 'hrsh7th/nvim-cmp'}
  use { 'haoliplus/cmp-path', requires = 'hrsh7th/nvim-cmp'}
  use { 'hrsh7th/cmp-cmdline', requires = 'hrsh7th/nvim-cmp'}

  -- For ultisnips users.
  use {'SirVer/ultisnips',
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
  }
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  -- community-maintained snippets
  use {'mileszs/ack.vim',
    setup = function()
      if vim.fn.executable('ag') == 1 then
        vim.g.ackprg = 'ag --vimgrep'
        vim.keymap.set('n', '<Leader>a', ':Ack<Space>', { noremap = true, silent = true })
      end
    end
  }
  use {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        -- your personnal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override = {
          zsh = {
            icon = "#",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          },
        };
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true;
        override_by_filename = {
          ["containerfile"] = {
            icon = "*",
            color = "#458ee5",
            cterm_color = "68",
            name = "containerfile",
          },
        };
      }
      require("nvim-web-devicons").set_icon {
        containerfile = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "containerfile"
        },
        dockerfile = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "dockerfile"
        }
      }

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
  use {
    'romgrk/barbar.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      -- Move to previous/next
      map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
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
      -- Close buffer
      map('n', '<Leader>c', '<Cmd>BufferClose<CR>', opts)
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
  use {
    'lambdalisue/suda.vim'
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() 
      require('colorizer').setup()
    end
  }
  -- install without yarn or npm
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })
  use({
    "glepnir/lspsaga.nvim",
    opt = true,
    branch = "main",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({})
    end,
    requires = {
        {"nvim-tree/nvim-web-devicons"},
        --Please make sure you install markdown and markdown_inline parser
        {"nvim-treesitter/nvim-treesitter"}
    }
  })
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    requires = {'nvim-tree/nvim-web-devicons'}
  }
  use 'rcarriga/nvim-notify'
end) -- packer.setup

require('plugins.nvim-cmp')
require('plugins.nvim-tree')
require('plugins.lsp')

