#! /usr/bin/env lua

-- 检查文件是否存在并读取内容的函数
local function read_os_release()
    local file = io.open("/etc/os-release", "r")
    if not file then
        return nil
    end
    local content = file:read("*all")
    file:close()
    return content
end

-- 检查是否为 Ubuntu 16.04
local function is_ubuntu_1604()
    local content = read_os_release()
    if not content then
        return false
    end
    -- 检查是否包含 Ubuntu 16.04 的特征
    return string.match(content, "Ubuntu") and string.match(content, "16.04")
end

local config = {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',
  enabled = function()
    return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
      and vim.bo.buftype ~= "prompt"
      and vim.b.completion ~= false
  end,

  -- use a release tag to download pre-built binaries
  version = '*',
  --- 
  --- curl https://sh.rustup.rs -sSf | sh
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = 'default',
      ['<C-]>'] = { 'accept' },
    },
    signature = {
      -- Enable signature help
      enabled = true,
      window = { border = 'single' }
    },
    completion = {
      menu = { border = 'single' },
      documentation = {
        window = { border = 'single' },
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = true
        }
      }
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { "sources.default" }
}


-- 根据系统版本设置变量
if is_ubuntu_1604() then
    config['build'] = 'cargo build --release'
end

return config
