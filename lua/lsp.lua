#! /usr/bin/env lua
--
-- lsp.lua
-- Copyright (C) 2022 lihao <lihao@fabu.ai>
--
-- Distributed under terms of the MIT license.
--

require('custom_callbacks')

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- open in new tab
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end
local servers = {
    "clangd",
    "pyright",
    -- "jedi_language_server",
}
local lsp_opts = {}

local capabilities = nil

local call_requires1 = function()
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
end;

local call_requires2 = function()
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
end;

if not pcall(call_requires1) and not pcall(call_requires2) then
    print('Failed to get capabilities');
end

for _, server_name in pairs(servers) do
  lsp_opts[server_name] = {
    -- When this particular server is ready (i.e. when installation is finished or the server is already installed),
    -- this function will be invoked. Make sure not to use the "catch-all" lsp_installer.on_server_ready()
    -- function to set up servers, to avoid doing setting up a server twice.
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local util = require("lspconfig/util")

lsp_opts["clangd"]["cmd"] = { "clangd", "--background-index", "--clang-tidy"}
lsp_opts["clangd"]["filetypes"] = { "c", "cpp", "cc", "h"}
lsp_opts["clangd"]["root_dir"] = function(fname)
    return util.root_pattern("compile_flags.txt")(fname) or util.path.dirname(fname)
end

-- lsp_opts["pyright"]["cmd"] = { "pyright", "--dependencies", "--ignoreexternal", "--lib"}
lsp_opts["pyright"]["cmd"] = { "pyright-langserver", "--stdio"}
lsp_opts["pyright"]["root_dir"] = function(fname)
    return util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or util.path.dirname(fname)
end
lsp_opts["pyright"]["settings"] = {
  python = {
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = "workspace",
      useLibraryCodeForTypes = false -- this is for avoiding lib member access error like cv.imread 
    }
  }
}
lsp_opts["pyright"]["single_file_support"] = true

-- Loop through the servers listed above.
for _, server_name in pairs(servers) do
    local opts = lsp_opts[server_name]
    require('lspconfig')[server_name].setup(opts)
end
