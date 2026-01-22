local function github_exists()
  local path = vim.fn.expand("~/.config/github-copilot/apps.json")
  local stat = vim.loop.fs_stat(path)
  if stat then
    return true
  else
    return false
  end
end

local function enable_copilot_lua()
  if vim.env.DEEPSEEK_API_KEY then
    return true
  else
    return github_exists()
  end
end

local function enable_copilot_vim()
  if enable_copilot_lua() then
    return false
  end
  return github_exists()
end

local function env_key_exists(key)
  local value = vim.env[key]
  return value ~= nil and value ~= ""
end

return {
  { -- github copilot
    "github/copilot.vim",
    enabled = enable_copilot_vim(),
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
  },
  { -- better copilot
    "zbirenbaum/copilot.lua",
    enabled = enable_copilot_lua(),
    opts = {
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
          position = "right", -- | top | left | right | bottom

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
          next = "<C-j>",
          prev = "<C-.>", --
          -- toggle = "<F12>", --
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
      server_opts_overrides = {
        listCount = 6, -- #completions for panel
        inlineSuggestCount = 3, -- #completions for getCompletions
      },
    },
  },
  { -- ai ui
    "olimorris/codecompanion.nvim",
    enabled = env_key_exists("DEEPSEEK_API_KEY"),
    opts = {
      strategies = {
        chat = {
          adapter = {
            -- name = "deepseek",
            -- model = "deepseek-chat",
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
        aidoki = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              api_key = os.getenv("AIDOKI_API_KEY"),
              url = "https://api.aidoki.cn",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "deepseek-chat",
                deepseek = "deepseek-chat"
              },
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
            is_slash_cmd = true,
            -- mapping = "<Leader>e",
            auto_submit = true,
            short_name = "docs", -- using this will allow you to use `/docs` to trigger this prompt
          },
          references = {
            {
              type = "file",
              path = {
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
        ["LanConvert"] = {
          strategy = "inline",
          description = "Convert code from other languages to the current buffer language",
          opts = {
            -- mapping = "<Leader>ch",
            short_name = "codeconvert",
            is_slash_cmd = true,
          },
          prompts = {
            {
              role = "system",
              content = "You are an expert programmer that converts code from one programming language to another.",
            },
            {
              role = "user",
              content = "<user_prompt>Please convert the following code to the language of current buffer(keeping the original code in comment for comparing)</user_prompt>",
            },
          },
        },
        ["ImplCode"] = {
          strategy = "inline",
          description = "Implement code descriped in the comment",
          opts = {
            -- mapping = "<Leader>ch",
            short_name = "implcode",
            is_slash_cmd = true,
          },
          prompts = {
            {
              role = "system",
              content = "You are an expert programmer that implements code based on the description in the comment.",
            },
            {
              role = "user",
              content = "<user_prompt>Please implement the code described in the comment</user_prompt>",
            },
          },
        },
        ["IImplCode"] = {
          strategy = "chat",
          description = "Implement code descriped in the comment(with interaction)",
          opts = {
            -- mapping = "<Leader>ch",
            short_name = "implcodei",
            is_slash_cmd = true,
          },
          prompts = {
            {
              role = "system",
              content = "You are an expert programmer that implements code based on the description in the comment. If you need more information, ask the user before implementing the code.",
            },
            {
              role = "user",
              content = "<user_prompt>Please implement the code described in the comment</user_prompt>",
            },
          },
        },
      },
    },
  },
}
