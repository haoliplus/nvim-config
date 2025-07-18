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
            end,
          },
        },
        mappings = {
          v = {
            j = {
              -- 不知道为什么，如果不这么设置。会在visual模式里，按下jk后自动退出
              k = false,
            },
          },
        },
      })
    end,
  },
  -- git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  { "tpope/vim-fugitive" },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        vim.keymap.set("n", "<F9>", ":TroubleToggle<cr>", { silent = true, noremap = true, desc = "TroubleToggle" }),
      })
    end,
  },
  {
    -- Install markdown preview, use npx if available.
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      if vim.fn.executable("npx") then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd([[Lazy load markdown-preview.nvim]])
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      if vim.fn.executable("npx") then
        vim.g.mkdp_filetypes = { "markdown" }
      end
    end,
  },
}
