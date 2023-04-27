#! /usr/bin/env lua
--
-- lsp.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--

require('plugins.lsp_callbacks')

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities())

local servers = {
  "clangd",
  "pyright",
  -- "beautysh"
-- "jedi_language_server",
}
local lsp_opts = {}
for _, server_name in pairs(servers) do
  lsp_opts[server_name] = {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local util = require("lspconfig/util")

lsp_opts["clangd"] = {
  cmd = { "clangd", "--background-index", "--clang-tidy"},
  filetypes = { "c", "cpp", "cc", "h"},
  root_dir = function(fname)
    return util.root_pattern("compile_flags.txt")(fname) or util.path.dirname(fname)
  end,
}

lsp_opts["pyright"] = {
  cmd = { "pyright-langserver", "--stdio"},
  root_dir = function(fname)
    return util.root_pattern(".git", "setup.py",  "setup.cfg",
      "pyproject.toml", "requirements.txt")(fname) or util.path.dirname(fname)
  end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = false -- this is for avoiding lib member access error like cv.imread
      }
    }
  },
  single_file_support = true
}


-- Loop through the servers listed above.
for _, server_name in pairs(servers) do
  local opts = lsp_opts[server_name]
  require('lspconfig')[server_name].setup(opts)
end

