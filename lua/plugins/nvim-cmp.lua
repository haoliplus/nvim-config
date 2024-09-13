#! /usr/bin/env lua
--
-- nvim-cmp.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--

-- Setup nvim-cmp.
local flag = true
return {
  -- complete sources for nvim-cmp
  { "hrsh7th/cmp-buffer", enabled = flag, dependencies = "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp", enabled = flag, dependencies = "hrsh7th/nvim-cmp" },
  { "haoliplus/cmp-path", enabled = flag, dependencies = "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-cmdline", enabled = flag, dependencies = "hrsh7th/nvim-cmp" },
  { "saadparwaiz1/cmp_luasnip", enabled = flag },
  -- {'quangnguyen30192/cmp-nvim-ultisnips'},
  {
    "hrsh7th/nvim-cmp",
    enabled = flag,
    dependencies = {
      -- If you want to enable filetype detection based on treesitter:
      -- requires = { "nvim-treesitter/nvim-treesitter" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
          }),
        },
        -- i: insert
        -- c: command
        -- n: normal
        mapping = {
          ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ["<C-e>"] = cmp.mapping({ -- useful when cowork copilot
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<C-g>'] = cmp.mapping(function(_)
            vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
          end),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        expirimental = {
          ghost_text = false
        },
        sources = cmp.config.sources({
          { name = "lazydev", group_index = 0 },
          { name = "nvim_lsp" },
          {
            name = "path",
            option = {
              trailing_slash = true,
              exclude = {
                "onboard_data",
                "/onboard_data",
              },
            },
          },
          { name = "luasnip", priority = 10 }, -- For ultisnips users.
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", {
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        sources = cmp.config.sources(
          -- {
          --   { name = 'path' }
          -- },
          {
            { name = "cmdline" },
          }
        ),
      })
    end,
  },
}
