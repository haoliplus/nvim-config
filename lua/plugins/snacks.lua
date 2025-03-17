return {
  "folke/snacks.nvim",
  enabled = false,
  priority = 1000,
  lazy = false,
  ---@diagnostic disable-next-line: undefined-doc-name
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true }, -- bigfile	Deal with big files	‼️
    -- dashboard = { enabled = true }, dashboard	Beautiful declarative dashboards	‼️
    -- explorer = { enabled = true }, -- explorer	A file explorer (picker in disguise)	‼️
    -- indent = { enabled = true }, indent	Indent guides and scopes
    input = { enabled = true }, -- input	Better vim.ui.input
    picker = { enabled = true }, -- picker	Picker for selecting items
    notifier = { enabled = true }, -- notifier	Pretty vim.notify
    quickfile = { enabled = false }, -- quickfile	When doing nvim somefile.txt, it will render the file as quickly as possible, before loading your plugins.	‼️
    scope = { enabled = false }, -- scope	Scope detection, text objects and jumping based on treesitter or indent
    scroll = { enabled = false }, -- scroll	Smooth scrolling	‼️
    -- statuscolumn = { enabled = true },
    words = { enabled = false }, -- words	Auto-show LSP references and quickly navigate between them	‼️
    -- bufdelete	Delete buffers without disrupting window layout
    -- debug	Pretty inspect & backtraces for debugging
    -- dim	Focus on the active scope by dimming the rest
    -- git	Git utilities
    -- gitbrowse	Open the current file, branch, commit, or repo in a browser (e.g. GitHub, GitLab, Bitbucket)
    -- image	Image viewer using Kitty Graphics Protocol, supported by kitty, wezterm and ghostty	‼️
    -- layout	Window layouts
    -- lazygit	Open LazyGit in a float, auto-configure colorscheme and integration with Neovim
    -- notify	Utility functions to work with Neovim's vim.notify
    -- profiler	Neovim lua profiler
    -- rename	LSP-integrated file renaming with support for plugins like neo-tree.nvim and mini.files.
    -- scratch	Scratch buffers with a persistent file
    -- statuscolumn	Pretty status column	‼️
    -- terminal	Create and toggle floating/split terminals
    -- toggle	Toggle keymaps integrated with which-key icons / colors
    -- util	Utility functions for Snacks (library)
    -- win	Create and manage floating windows or splits
    -- zen	Zen mode • distraction-free coding
  },
}
