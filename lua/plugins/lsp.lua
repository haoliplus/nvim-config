#! /usr/bin/env lua
--
-- lsp.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
      -- "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    opts = {
      ui = {
        windows = {
          default_options = {
            border = "rounded",
          },
        },
      },
    },
    config = function()
      -- require("lazydev").setup()
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1 })
      end, { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1 })
      end, { desc = "Go to next diagnostic" })
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set loclist" })

      require("lspconfig.ui.windows").default_options = {
        border = "rounded",
      }

      local python_workspace = require("python_workspace")

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
          -- vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show hover" })

          vim.keymap.set("n", "K", function()
            local hover_clients = vim.lsp.get_clients({
              bufnr = ev.buf,
              method = "textDocument/hover",
            })
            if #hover_clients == 0 then
              vim.diagnostic.open_float()
              return
            end

            vim.lsp.buf.hover({ border = "rounded" })
          end, { buffer = ev.buf, desc = "Show hover" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to implementation" })
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Show signature help" })
          vim.keymap.set(
            "n",
            "<space>wa",
            vim.lsp.buf.add_workspace_folder,
            { buffer = ev.buf, desc = "Add workspace folder" }
          )
          vim.keymap.set(
            "n",
            "<space>wr",
            vim.lsp.buf.remove_workspace_folder,
            { buffer = ev.buf, desc = "Remove workspace folder" }
          )
          vim.keymap.set("n", "<space>wl", function()
            vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO, {
              title = "LSP Workspaces",
            })
          end, { buffer = ev.buf, desc = "List workspace folders" })
          vim.keymap.set(
            "n",
            "<space>D",
            vim.lsp.buf.type_definition,
            { buffer = ev.buf, desc = "Go to type definition" }
          )
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "References" })
          vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      }) -- end LspAttach

      -- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- local function call_requires()
      --   return require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- end

      local capabilities = nil
      -- local status, ret = pcall(call_requires)
      -- if status then
      --   capabilities = ret
      -- end
      capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        "clangd",
        "pyright",
        "ruff",
        "lua_ls",
        -- "gopls",
        "ts_ls",
        "bashls",
        -- "jedi_language_server",
      }
      local lsp_opts = {}

      -- Clangd

      local clang_file_state = {
        id = 0,
        step = 0, -- 0: just created, 1: shown, 2: completed
      }
      -- local clangd_handlers = {}
      local clangd_handlers = {
        ["textDocument/clangd.fileStatus"] = function(_, result, ctx, _)
          if not result.state then
            return
          end
          local message = result.state
          local opts = {
            key = "clangd.fileStatus",
            group = ctx.client_id,
            annote = "clangd",
            ttl = math.huge,
          }

          if message == "idle" then
            if clang_file_state.step ~= 1 then
              clang_file_state.step = 2
              return
            end
            clang_file_state.step = 2
            message = "Completed"
            opts.ttl = 0
            vim.notify(message, vim.log.levels.INFO, opts)
            return
          end

          -- delay notification by 0.5 second
          -- only show it if it is not complete
          local id = clang_file_state.id + 1
          clang_file_state.id = id
          clang_file_state.step = 0
          local timer = vim.uv.new_timer()
          if not timer then
            return
          end
          timer:start(500, 0, function()
            timer:stop()
            timer:close()
            vim.schedule(function()
              if clang_file_state.id == id and clang_file_state.step == 0 then
                clang_file_state.step = 1
                vim.notify(message, vim.log.levels.INFO, opts)
              end
            end)
          end)
        end,
      }
      -- NVIM_LSP_CLANGD_CMD="docker exec -i container_name /usr/bin/clangd --background-index --clang-tidy --offset-encoding=utf-16"
      -- NVIM_LSP_CLANGD_CMD="ssh dev@host 'clangd --background-index --clang-tidy --offset-encoding=utf-16'"
      local clangd_env_cmd = vim.env.NVIM_LSP_CLANGD_CMD
      if clangd_env_cmd and clangd_env_cmd ~= ""  then
        -- do thing
        lsp_opts["clangd"] = {
          -- cmd = {
          --   "docker", "exec", "-i", "example",
          --   "/usr/bin/clangd",
          --   "--background-index",
          --   "--clang-tidy",
          --   "--offset-encoding=utf-16",
          -- },
          cmd = vim.split(clangd_env_cmd, " ", { trimempty = true }),
          -- single_file_support = true,
          filetypes = { "c", "cpp", "cc", "h" },
          root_markers = { "compile_flags.txt", ".git" },
          init_options = {
            clangdFileStatus = true, -- show clangd file status
            usePlaceholders = true, -- enable placeholders
            completeUnimported = true, -- enable auto import
          },
          handlers = clangd_handlers,
        }
      else
        -- !!! You should instgall both clang-x/gcc-x/g++-x
        -- ${XDG_CONFIG_HOME}/.config/clangd/config.yaml
        -- https://github.com/clangd/clangd/issues/363
        -- CompileFlags:
        --   Add: [
        --     # -I=/usr/include/c++/11
        --       -isystem,
        --       /usr/include/c++/11,
        --       -isystem,
        --       /usr/include/c++/11/backward,
        --       -isystem,
        --       /usr/local/include,
        --       -isystem,
        --       /usr/include,
        --       -isystem,
        --       /usr/include/x86_64-linux-gnu/c++/11,
        --   ]

        -- Using `CLANGD_FLAGS="--query-driver=/usr/bin/c++" clangd  --enable-config --check=main.cpp` to debug
        lsp_opts["clangd"] = {
          -- cmd = { "clangd", "--background-index", "--clang-tidy"},
          cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
          filetypes = { "c", "cpp", "cc", "h", "cuda" },
          root_markers = {
            ".clangd",
            ".clang-tidy",
            ".clang-format",
            "compile_commands.json",
            "compile_flags.txt",
            "configure.ac",
            ".git",
          },
          init_options = {
            clangdFileStatus = true, -- show clangd file status
            usePlaceholders = true, -- enable placeholders
            completeUnimported = true, -- enable auto import
          },
          handlers = clangd_handlers,
        }
      end
      -- function _G.lsp_progress()
      --   if vim.lsp.buf_get_clients() > 0 then
      --     local lsp = vim.lsp.util.get_progress_messages()[1]
      --     if lsp then
      --       local name = lsp.name or ""
      --       local msg = lsp.message or ""
      --       local percentage = lsp.percentage or 0
      --       local title = lsp.title or ""
      --       return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
      --     end
      --   end
      --   return ""
      -- end
      --
      -- vim.opt.statusline = [[%{%v:lua.require'foo'.lsp_progress()%}]]
      -- tsserver
      lsp_opts["ts_ls"] = {
        init_options = {
          preferences = {
            -- File is a CommonJS module; it may be converted to an ES module.
            disableSuggestions = true,
          },
        },
      }
      lsp_opts["ruff"] = {
        capabilities = capabilities,
        root_dir = function(bufnr, on_dir)
          on_dir(python_workspace.current_python_workspace(bufnr))
        end,
        init_options = {
          settings = {
            path = "ruff-lsp",
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
          },
        },
      }

      -- Pyright
      lsp_opts["pyright"] = {
        cmd = { "pyright-langserver", "--stdio" },
        before_init = function(_, config)
          config.settings = config.settings or {}
          config.settings.python = config.settings.python or {}
          local workspace = type(config.root_dir) == "string" and config.root_dir or python_workspace.current_python_workspace()
          config.settings.python.pythonPath = python_workspace.get_python_path(workspace)
        end,
        root_dir = function(bufnr, on_dir)
          on_dir(python_workspace.current_python_workspace(bufnr))
        end,
        capabilities = (function()
          local py_capabilities = vim.lsp.protocol.make_client_capabilities()
          py_capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
          return py_capabilities
        end)(),
        settings = {
          pyright = {
            disableOrganizeImports = true, -- Using Ruff
          },
          python = {
            analysis = {
              ignore = { "*" }, -- Using Ruff
              autoSearchPaths = true,
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              diagnosticSeverityOverrides = {
                reportUnusedImport = "none",
                reportUnusedClass = "none",
                reportUnusedFunction = "none",
                reportUnusedVariable = "none",
                reportOptionalMemberAccess = "none",
                reportUnknownMemberType = "none",
              },
            },
          },
        },
        single_file_support = true,
      } -- end pyright

      -- lua_ls
      lsp_opts["lua_ls"] = {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              -- library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            -- telemetry = {
            --   enable = false,
            -- },
          },
        },
      }
      lsp_opts["gopls"] = {}

      -- -- Loop through the servers listed above.
      for _, server_name in pairs(servers) do
        if lsp_opts[server_name] == nil then
          lsp_opts[server_name] = {}
        end
        local opts = lsp_opts[server_name]
        if opts["capabilities"] == nil then
          opts["capabilities"] = capabilities
        end
        opts["flags"] = {
          debounce_text_changes = 150,
        }
        -- legacy
        -- require("lspconfig")[server_name].setup(opts)
        -- new
        vim.lsp.config(server_name, opts)
        vim.lsp.enable(server_name)
      end
    end,
  }, -- lsp "neovim/nvim-lspconfig",
  { -- better quickfix window
    "kevinhwang91/nvim-bqf",
  },
  -- { -- show lsp parse status
  --   "nvim-lua/lsp-status.nvim",
  --   enabled = false,
  -- },
  { -- show lspprocess
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        override_vim_notify = true
      }
      -- options
    },
  },
}
