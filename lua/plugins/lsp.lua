#! /usr/bin/env lua
--
-- lsp.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--
return {
	{ "hrsh7th/cmp-nvim-lsp", dependencies = "hrsh7th/nvim-cmp", enabled = true },
	{
		"neovim/nvim-lspconfig",
		enabled = true,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- require('plugins.utils.lsp_callbacks')
			-- print(vim.inspect(vim.api.nvim_list_runtime_paths()))
			-- require("plugins.utils.lsp_callbacks")

			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

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
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<space>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local servers = {
				"clangd",
				"pyright",
				"ruff_lsp",
				"lua_ls",
				"gopls",
				"tsserver",
				"bashls",
				-- "jedi_language_server",
			}
			local lsp_opts = {}

			local util = require("lspconfig/util")

			-- Clangd

			if vim.fn.hostname() == "in_dev_docker" then
				-- do thing
				lsp_opts["clangd"] = {
					cmd = {
						"/usr/bin/clangd",
						"--background-index",
						"--clang-tidy",
						"--offset-encoding=utf-16",
					},
					filetypes = { "c", "cpp", "cc", "h" },
					root_dir = function(fname)
						return util.root_pattern("compile_flags.txt")(fname) or util.path.dirname(fname)
					end,
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
					root_dir = function(fname)
						return util.root_pattern("compile_flags.txt")(fname) or util.path.dirname(fname)
					end,
				}
			end
			-- tsserver
			lsp_opts["tsserver"] = {
				init_options = {
					preferences = {
						-- File is a CommonJS module; it may be converted to an ES module.
						disableSuggestions = true,
					},
				},
			}
			-- ruff_lsp

			lsp_opts["ruff_lsp"] = {
				root_dir = function(fname)
					return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
						fname
					) or util.path.dirname(fname)
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
				root_dir = function(fname)
					return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
						fname
					) or util.path.dirname(fname)
				end,
				capabilities = (function()
					local py_capabilities = vim.lsp.protocol.make_client_capabilities()
					py_capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
					return py_capabilities
				end)(),
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							typeCheckingMode = "basic",
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = false, -- this is for avoiding lib member access error like cv.imread
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
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
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
				require("lspconfig")[server_name].setup(opts)
			end
		end,
	}, -- lsp "neovim/nvim-lspconfig",
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
	{ "kevinhwang91/nvim-bqf" },
}
