local function enable_copilot_lua()
  return true
end

local function enable_copilot_vim()
  return not enable_copilot_lua()
end

return {
  {
    "github/copilot.vim",
    enabled = enable_copilot_vim(),
    config = function()
      -- vim.g.copilot_no_tab_map = true
      --
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = enable_copilot_lua(),
    config = function()
      -- vim.g.copilot_no_tab_map = true
      --
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            -- accept = "<C-;>",
            accept = "<C-o>", -- alt
            -- accept_word = false,
            -- accept_line = false,
            next = "<C-,>",
            prev = "<C-.>",
            -- dismiss = "<C-=>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          txt = false,
          conf = false,
          json = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    config = function()
      -- vim.g.copilot_no_tab_map = true
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = {
              name = "deepseek",
              model = "deepseek-chat",
            },
          },
          inline = {
            adapter = {
              name = "deepseek",
              model = "deepseek-chat",
            },
          },
        },
        opts = {
          log_level = "DEBUG", -- or "TRACE"
        },
        adapters = {
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = os.getenv("DEEPSEEK_API_KEY"),
              },
            })
          end,
        },
        prompt_library = {
          ["Docusaurus"] = {
            strategy = "chat",
            description = "Write code comment for me",
            opts = {
              index = 11,
              is_slash_cmd = false,
              auto_submit = true,
              short_name = "docs",
            },
            references = {
              {
                type = "file",
                path = {
                  -- "doc/.vitepress/config.mjs",
                  -- "lua/codecompanion/config.lua",
                  -- "README.md",
                },
              },
            },
            prompts = {
              {
                role = "user",
                content = [[I'm rewriting the comment as documentation for this code snip]],
              },
            },
          },
        },
      })
    end,
  },
}
