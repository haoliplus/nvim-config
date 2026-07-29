return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")

      local function file_name(bufnr)
        return vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
      end

      local function python_formatters(bufnr)
        local name = file_name(bufnr)
        if name == "main.py" or name == "asgi.py" or name == "wsgi.py" then
          return { "black" }
        end
        return { "isort", "black" }
      end

      local function format_buffer()
        local bufnr = vim.api.nvim_get_current_buf()
        local timeout_ms = vim.bo[bufnr].filetype == "python" and 5000 or 1000
        conform.format({
          bufnr = bufnr,
          async = false,
          lsp_format = "fallback",
          timeout_ms = timeout_ms,
        })
      end

      local function format_range(line1, line2)
        local bufnr = vim.api.nvim_get_current_buf()
        local timeout_ms = vim.bo[bufnr].filetype == "python" and 5000 or 1000
        conform.format({
          bufnr = bufnr,
          async = false,
          lsp_format = "fallback",
          timeout_ms = timeout_ms,
          range = {
            start = { line1, 0 },
            ["end"] = { line2, 0 },
          },
        })
      end

      local function format_write()
        format_buffer()
        vim.cmd.write()
      end

      local function format_command(opts)
        if opts.range and opts.range > 0 then
          format_range(opts.line1, opts.line2)
        else
          format_buffer()
        end
      end

      local function format_write_command(opts)
        format_command(opts)
        vim.cmd.write()
      end

      vim.keymap.set("n", "<Leader>F", format_write, { noremap = true, silent = true, desc = "FormatWrite" })
      vim.keymap.set("x", "<Leader>F", function()
        local start_line = vim.fn.line("v")
        local end_line = vim.fn.line(".")
        format_range(math.min(start_line, end_line), math.max(start_line, end_line))
      end, { noremap = true, silent = true, desc = "Format selection" })
      vim.api.nvim_create_user_command("F", format_write_command, { desc = "FormatWrite", range = true })
      vim.api.nvim_create_user_command("Format", format_command, { desc = "Format current buffer", range = true })
      vim.api.nvim_create_user_command("FormatLock", format_command, { desc = "Format current buffer", range = true })
      vim.api.nvim_create_user_command("FormatWrite", format_write_command, { desc = "Format and write current buffer", range = true })
      vim.api.nvim_create_user_command("FormatWriteLock", format_write_command, { desc = "Format and write current buffer", range = true })

      conform.setup({
        log_level = vim.log.levels.WARN,
        notify_on_error = true,
        formatters_by_ft = {
          lua = { "stylua" },
          python = python_formatters,
          go = { "gofumpt" },
          cpp = { "clang-format" },
          cuda = { "clang-format" },
          yaml = { "prettier" },
          javascript = { "prettier" },
          html = { "prettier" },
          json = { "jq" },
          ["*"] = { "trim_whitespace" },
        },
        formatters = {
          black = {
            -- Mason may install Black in a Python 3.11 venv while project configs target py312.
            append_args = { "--fast" },
          },
          stylua = function(bufnr)
            if file_name(bufnr) == "special.lua" then
              return {}
            end
            return {
              append_args = {
                "--indent-type",
                "Spaces",
                "--indent-width",
                "2",
                "--search-parent-directories",
              },
            }
          end,
          isort = {
            command = vim.fn.stdpath("data") .. "/mason/bin/isort",
            append_args = { "--quiet" },
          },
        },
      })
    end,
  },
}
