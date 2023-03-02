#! /usr/bin/env lua
--
-- nvim-tree.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--


-- `<CR>`            edit                open a file or folder; root will cd to the above directory
-- `I`               toggle_git_ignored  toggle visibility of files/folders hidden via |git.ignore| option
-- `H`               toggle_dotfiles     toggle visibility of dotfiles via |filters.dotfiles| option
-- `U`               toggle_custom       toggle visibility of files/folders hidden via |filters.custom| option
-- `R`               refresh             refresh the tree
-- `a`               create              add a file; leaving a trailing `/` will add a directory
-- `d`               remove              delete a file (will prompt for confirmation)
-- `D`               trash               trash a file via |trash| option
-- `r`               rename              rename a file
-- `x`               cut                 add/remove file/directory to cut clipboard
-- `c`               copy                add/remove file/directory to copy clipboard
-- `p`               paste               paste from clipboard; cut clipboard has precedence over copy; will prompt for confirmation
-- `y`               copy_name           copy name to system clipboard
-- `Y`               copy_path           copy relative path to system clipboard
-- `gy`              copy_absolute_path  copy absolute path to system clipboard
-- `s`               system_open         open a file with default system application or a folder with default file manager, using |system_open| option
-- `f`               live_filter         live filter nodes dynamically based on regex matching.
-- `F`               clear_live_filter   clear live filter
-- `q`               close               close tree window
-- `W`               collapse_all        collapse the whole tree
-- `E`               expand_all          expand the whole tree, stopping after expanding |actions.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder
-- `S`               search_node         prompt the user to enter a path and then expands the tree to match the path
-- `.`               run_file_command    enter vim command mode with the file the cursor is on
-- `<C-k>`           toggle_file_info    toggle a popup with file infos about the file under the cursor
-- `g?`              toggle_help         toggle help
-- `m`               toggle_mark         Toggle node in bookmarks
-- `bmv`             bulk_move           Move all bookmarked nodes into specified location

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
  renderer = {
    icons = {
      show = {
       git = true,
       folder = true,
       file = true,
       folder_arrow = true
      }
    }
  },
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
   custom = {"*.egg-info", ".git", 
   "__pycache__", "arcanist-extensions",
   "bazel-genfiles", 
   "bazel-bin", "bazel-fabupilot", "bazel-out", "bazel-testlogs",
   ".vscode"},
   exclude = {},
  },
  git = {ignore = false}
}

vim.opt.splitright = true

