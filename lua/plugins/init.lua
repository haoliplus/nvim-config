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
    opts = {
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
    },
  },
  -- git
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  -- git wrapper
  { "tpope/vim-fugitive" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = vim.g.is_win and "cd app && powershell -ExecutionPolicy Bypass -File install.cmd" or "cd app && ./install.sh",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
}
