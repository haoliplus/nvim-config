#! /usr/bin/env lua
--
-- nvim-cmp.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--

-- Setup nvim-cmp.
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    {"quangnguyen30192/cmp-nvim-ultisnips",
    config = function()
      -- optional call to setup (see customization section)
      require("cmp_nvim_ultisnips").setup{}
    end},
    {'SirVer/ultisnips'},
    -- If you want to enable filetype detection based on treesitter:
    -- requires = { "nvim-treesitter/nvim-treesitter" },
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      -- i: insert
      -- c: command
      -- n: normal
      mapping = {
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path',
          option = {
            trailing_slash = true,
            exclude = {
              "onboard_data",
              "/onboard_data"
            },
          },
        },
        { name = 'ultisnips', priority = 10 }, -- For ultisnips users.
      }, {
        { name = 'buffer' },
      })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      sources = cmp.config.sources(
        -- {
        --   { name = 'path' }
        -- },
        {
          { name = 'cmdline' }
        })
    })
  end
}
