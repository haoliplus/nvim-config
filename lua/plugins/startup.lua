---@diagnostic disable: undefined-doc-name
-- stylua: ignore

local vim_version_major = vim.version().major
local vim_version_minor = vim.version().minor
local vim_version_patch = vim.version().patch
local vim_version_build = vim.version().build
local version = vim_version_major .. "." .. vim_version_minor .. "." .. vim_version_patch .. "+" .. vim_version_build

local function check_env_is_set(env_var, show_value)
  local value = os.getenv(env_var)
  if value then
    return env_var .. (show_value and ": " .. value or " ✔")
  else
    return env_var .. " ✘"
  end
end

return {
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    opts = {
      config = {
        week_header = {
          enable = true,
          concat = "vim:" .. version,
          append = {
            check_env_is_set("AIDOKI_AUTH_TOKEN"),
            check_env_is_set("ANTHROPIC_AUTH_TOKEN"),
            check_env_is_set("DEEPSEEK_API_KEY"),
            "-------",
            check_env_is_set("ANTHROPIC_MODEL", true),
            check_env_is_set("ANTHROPIC_FAST_MODEL", true),
            check_env_is_set("ANTHROPIC_SMALL_FAST_MODEL", true),
            check_env_is_set("ANTHROPIC_BASE_URL", true),
          },
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
