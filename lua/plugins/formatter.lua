return {
  {
    "mhartington/formatter.nvim",
    enabled = true,
    config = function(_, _) -- stylua: ignore
      -- Utilities for creating configurations
      local util = require("formatter.util")
      vim.keymap.set("n", "<Leader>F", ":FormatWrite<CR>", { noremap = true, silent = true, desc = "FormatWrite" })
      vim.cmd("command! F FormatWrite")

      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require("formatter").setup({ -- stylua: ignore
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- You can also define your own configuration
            function()
              -- Supports conditional formatting
              if util.get_current_buffer_file_name() == "special.lua" then
                return nil
              end

              -- Full specification of configurations is down below and in Vim help
              --files
              return {
                -- cargo install stylua
                exe = "stylua",
                args = {
                  "--indent-type Spaces",
                  "--indent-width 2",
                  "--search-parent-directories",
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--",
                  "-",
                },
                stdin = true,
              }
            end,
          }, -- lua

          python = {
            require("formatter.filetypes.python").black,
            -- require("formatter.filetypes.python").isort
            function()
              return {
                exe = "isort",
                args = {
                  "--quiet",
                  "--",
                  util.escape_path(util.get_current_buffer_file_path()),
                },
                stdin = false,
              }
            end,
          }, -- python

          go = {
            require("formatter.filetypes.go").gofumpt,
          },
          cpp = {
            require("formatter.filetypes.cpp").clangformat,
          },
          cuda = {
            require("formatter.filetypes.cpp").clangformat,
          },
          yaml = {
            require("formatter.filetypes.yaml").prettier,
          },
          javascript = {
            require("formatter.filetypes.javascript").prettier,
          },
          html = {
            require("formatter.filetypes.html").prettier,
          },

          json = {
            -- 使用 jq 来格式化 JSON 文件
            function()
              return {
                exe = "jq",
                args = { "." },
                stdin = true,
              }
            end,
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        }, -- filetype
      })
    end,
  },
}
