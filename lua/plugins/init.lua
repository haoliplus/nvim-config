#! /usr/bin/env lua
--
-- plugins/init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--

return {
  -- Generate doc header and something
  { "vim-scripts/DoxygenToolkit.vim" },
  -- Using jj to escape
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        i = {
            [" "] = {
                ["<tab>"] = function()
                    -- Defer execution to avoid side-effects
                    vim.defer_fn(function()
                        -- set undo point
                        vim.o.ul = vim.o.ul
                        require("luasnip").expand_or_jump()
                    end, 1)
                end
            }
        },
        mappings = {
          v = {
              j = {
                  -- 不知道为什么，如果不这么设置。会在visual模式里，按下jk后自动退出
                  k = false,
              }
          }
        }
      })
    end,
  },
  -- git
  { "tpope/vim-fugitive" },
  {
    "airblade/vim-gitgutter",
    init = function()
      vim.g.gitgutter_enabled = 0
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        vim.keymap.set("n", "<F9>", ":TroubleToggle<cr>", { silent = true, noremap = true }),
      })
    end,
  },
  ---- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
