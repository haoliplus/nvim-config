-- check "~/.config/github-copilot/hosts.json", read content
---@diagnostic disable-next-line: undefined-global, missing-fields, undefined-field, unused-function, unused-local, undefined-doc-class, undefined-doc-param
local function enable_avante_impl()
  local Path = require("plenary.path")
  local os_name = vim.loop.os_uname().sysname
  local xdg_config = vim.fn.expand("$XDG_CONFIG_HOME")
  ---@type string
  local config_dir = xdg_config
  if xdg_config and vim.fn.isdirectory(xdg_config) > 0 then
    config_dir = xdg_config
  elseif os_name == "Linux" or os_name == "Darwin" then
    config_dir = vim.fn.expand("~/.config")
  else
    config_dir = vim.fn.expand("~/AppData/Local")
  end

  --- hosts.json (copilot.lua), apps.json (copilot.vim)
  ---@diagnostic disable-next-line: undefined-global, missing-fields, undefined-field, unused-function, unused-local, undefined-doc-class, undefined-doc-param
  ---@diagnostic disable-next-line: undefined-doc-name
  ---@type Path[]
  local paths = vim.iter({ "hosts.json", "apps.json" }):fold({}, function(acc, path)
    local yason = Path:new(config_dir):joinpath("github-copilot", path)
    if yason:exists() then
      table.insert(acc, yason)
    end
    return acc
  end)
  if #paths == 0 then
    return false
  end
  return true
end

local function enable_parrot()
  if os.getenv("OPENROUTER_API_KEY") == nil then
    return false
  end
  return true
end

---@diagnostic disable-next-line: undefined-global, missing-fields, undefined-field, unused-function, unused-local
local function enable_avante()
  -- if enable_parrot() == true then
  --   return false
  -- end
  -- if pcall(enable_avante_impl) then
  --   return false
  -- end
  return false
end

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    enabled = false,
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- provider = "deepseek",
      -- auto_suggestions_provider="deepseek",
      -- vendors = {
      --   deepseek = {
      --     __inherited_from = "openai",
      --     api_key_name = "DEEPSEEK_API_KEY",
      --     endpoint = "https://api.deepseek.com/",
      --     model = "deepseek-chat",
      --   },
      --
      -- },
      -- add any opts here
      -- @alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = "copilot", -- Recommend using Claude
      -- auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      -- ---@type AvanteSupportedProvider
      copilot = {
        endpoint = "https://api.githubcopilot.com",
        model = "gpt-4o-2024-08-06",
        proxy = nil, -- [protocol://]host[:port] Use this proxy
        allow_insecure = false, -- Allow insecure server connections
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
      },
      ---Specify the special dual_boost mode
      ---1. enabled: Whether to enable dual_boost mode. Default to false.
      ---2. first_provider: The first provider to generate response. Default to "openai".
      ---3. second_provider: The second provider to generate response. Default to "claude".
      ---4. prompt: The prompt to generate response based on the two reference outputs.
      ---5. timeout: Timeout in milliseconds. Default to 60000.
      ---How it works:
      --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
      ---Note: This is an experimental feature and may not work as expected.
      dual_boost = {
        enabled = false,
        first_provider = "openai",
        second_provider = "claude",
        prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
        timeout = 60000, -- Timeout in milliseconds
      },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },
      hints = { enabled = true },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "right", -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width
        sidebar_header = {
          enabled = true, -- true, false to enable/disable the header
          align = "center", -- left, center, right for title
          rounded = true,
        },
        input = {
          prefix = "> ",
          height = 8, -- Height of the input window in vertical layout
        },
        edit = {
          border = "rounded",
          start_insert = true, -- Start insert mode when opening the edit window
        },
        ask = {
          floating = false, -- Open the 'AvanteAsk' prompt in a floating window
          start_insert = true, -- Start insert mode when opening the ask window
          border = "rounded",
          ---@type "ours" | "theirs"
          focus_on_apply = "ours", -- which diff to focus after applying
        },
      },
      highlights = {
        ---@diagnostic disable-next-line: undefined-doc-name
        ---@type AvanteConflictHighlights
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = true,
        ---@type string | fun(): any
        list_opener = "copen",
        --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
        --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
        --- Disable by setting to -1.
        override_timeoutlen = 500,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "frankroeder/parrot.nvim",
    dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
    enabled = false,
    opts = {},
    config = function()
      require("parrot").setup({
        chat_user_prefix = "🗨(Leader+;):",
        chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<Leader>g" },
        prompts = {
          ["Spell"] = "I want you to proofread the provided text and fix the errors.", -- e.g., :'<,'>PrtRewrite Spell
          ["Comment"] = "Provide a comment that explains what the snippet is doing.", -- e.g., :'<,'>PrtPrepend Comment
          ["Complete"] = "Continue the implementation of the provided snippet in the file {{filename}}.", -- e.g., :'<,'>PrtAppend Complete
        },
        -- Providers must be explicitly added to make them available.
        providers = {
          deepseek = {
            name = "deepseek", -- this name shold match the key in the providers table
            style = "openai",
            api_key = os.getenv("DEEPSEEK_API_KEY"),
            endpoint = "https://api.deepseek.com/chat/completions",
            -- topic_prompt = topic_prompt,
            topic = {
              model = "deepseek-chat",
              params = { max_tokens = 64 },
            },
            models = { "deepseek-chat" },
            params = {
              command = { temperature = 1.1, top_p = 1 },
              chat = { temperature = 1.1, top_p = 1 },
            },
            -- Custom payload preprocessing
            preprocess_payload = function(payload)
              -- Modify payload for your API format
              return payload
            end,
            -- Custom response processing
            process_stdout = function(response)
              -- Parse streaming response from your API
              local success, decoded = pcall(vim.json.decode, response)
              if success and decoded.content then
                return decoded.content
              end
            end,
          },
          openrouter = {
            style = "openai",
            name = "openrouter", -- this name shold match the key in the providers table
            -- api_key = os.getenv("DEEPSEEK_API_KEY"),
            api_key = os.getenv("OPENROUTER_API_KEY"),
            -- OPTIONAL: Alternative methods to retrieve API key
            -- Using GPG for decryption:
            -- api_key = { "gpg", "--decrypt", vim.fn.expand("$HOME") .. "/anthropic_api_key.txt.gpg" },
            -- Using macOS Keychain:
            -- api_key = { "/usr/bin/security", "find-generic-password", "-s anthropic-api-key", "-w" },
            -- endpoint = "https://api.anthropic.com/v1/messages",
            -- endpoint = "https://openrouter.ai/api/v1",
            endpoint = "https://openrouter.ai/api/v1/chat/completions",
            models = {
              "anthropic/claude-3.7-sonnet",
              "deepseek/deepseek-r1",
              "openai/gpt-4o-mini",
              "google/gemini-2.0-pro-exp-02-05:free",
            },
            -- topic_prompt = "You only respond with 3 to 4 words to summarize the past conversation.",
            -- usually a cheap and fast model to generate the chat topic based on
            -- the whole chat history
            -- parameters to summarize chat
            topic = {
              model = "openai/gpt-4o-mini",
              params = { max_completion_tokens = 64 },
            },
            -- default parameters
            params = {
              command = { temperature = 1.1, top_p = 1 },
              chat = { temperature = 1.1, top_p = 1 },
            },
            -- Custom payload preprocessing
            preprocess_payload = function(payload)
              -- Modify payload for your API format
              return payload
            end,
            -- Custom response processing
            process_stdout = function(response)
              -- Parse streaming response from your API
              local success, decoded = pcall(vim.json.decode, response)
              if success and decoded.content then
                return decoded.content
              end
            end,
          },
          volcengine = {
            style = "openai",
            name = "volcengine", -- this name shold match the key in the providers table
            -- api_key = os.getenv("DEEPSEEK_API_KEY"),
            api_key = os.getenv("VOLCENGINE_API_KEY"),
            -- OPTIONAL: Alternative methods to retrieve API key
            -- Using GPG for decryption:
            -- api_key = { "gpg", "--decrypt", vim.fn.expand("$HOME") .. "/anthropic_api_key.txt.gpg" },
            -- Using macOS Keychain:
            -- api_key = { "/usr/bin/security", "find-generic-password", "-s anthropic-api-key", "-w" },
            -- endpoint = "https://api.anthropic.com/v1/messages",
            -- endpoint = "https://openrouter.ai/api/v1",
            endpoint = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
            models = {
              "deepseek-r1-250528",
              "deepseek-v3-250324",
            },
            -- topic_prompt = "You only respond with 3 to 4 words to summarize the past conversation.",
            -- usually a cheap and fast model to generate the chat topic based on
            -- the whole chat history
            -- parameters to summarize chat
            topic = {
              model = "deepseek-v3-250324",
              params = { max_completion_tokens = 64 },
            },
            -- default parameters
            params = {
              command = { temperature = 1.1, top_p = 1 },
              chat = { temperature = 1.1, top_p = 1 },
            },
            -- Custom payload preprocessing
            preprocess_payload = function(payload)
              -- Modify payload for your API format
              return payload
            end,
            -- Custom response processing
            process_stdout = function(response)
              -- Parse streaming response from your API
              local success, decoded = pcall(vim.json.decode, response)
              if success and decoded.content then
                return decoded.content
              end
            end,
          },
        },
        chat_dir = vim.uv.fs_realpath(tostring(vim.fn.stdpath("data")):gsub("/$", "") .. "/parrot/chats"),
      })
    end,
  },
}
