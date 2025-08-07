---@diagnostic disable: undefined-doc-name
-- stylua: ignore

local vim_version_major = vim.version().major
local vim_version_minor = vim.version().minor
local vim_version_patch = vim.version().patch
local vim_version_build = vim.version().build
local version = vim_version_major .. "." .. vim_version_minor .. "." .. vim_version_patch .. "+" .. vim_version_build

return {
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    opts = {
      config = {
        week_header = {
          enable = true,
          concat = "vim:" .. version,
          append = { "Hello" },
        },
        packages = { enable = true }, -- show how many plugins neovim loaded
        mru = { limit = 10, icon = "* ", label = "Recent Files" },
        footer = { "hello: " .. version }, -- footer
        -- limit how many projects list, action when you press key or enter it will run this action.
        -- action can be a functino type, e.g.
        -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
        project = { enable = true, limit = 8, icon = "- ", label = "Recent Project" },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = " Recent Files",
            group = "Files",
            action = "Telescope oldfiles",
            key = "a",
          },
        },
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
