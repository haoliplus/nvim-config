#! /usr/bin/env lua
--
-- nvim-tree.lua
-- Copyright (C) 2022 lihao <lihao@fabu.ai>
--
-- Distributed under terms of the MIT license.
--

require('nvim-web-devicons').setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
  override = {
    zsh = {
    icon = "#",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"}
  };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require'nvim-tree'.setup {
  open_on_tab        = true,
  actions = {
   change_dir = {
    enable = true,
    global = false,
   },
   open_file = {
    quit_on_open = false,
    resize_window = true,
    window_picker = {
     enable = true,
     chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
     exclude = {
      filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
      buftype = { "nofile", "terminal", "help" },
     },
    },
   },
  },
  filters = {
   dotfiles = false,
   custom = {},
   exclude = {"bazel-genfiles", "bazel-bin", ".vscode"},
  },
}

vim.opt.splitright = true

