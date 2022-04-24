#! /usr/bin/env lua
--
-- nvim-cmp.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--

-- Setup nvim-cmp.
local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  -- i: insert
  -- c: command
  -- n: normal
  mapping = {
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
		['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path',
      option = {
        trailing_slash = true
      },
    },
    { name = 'ultisnips' }, -- For ultisnips users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources(
  -- {
  --   { name = 'path' }
  -- }, 
  {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer_servers = require('nvim-lsp-installer.servers')

local servers = {
    "clangd",
    "pyright",
    -- "jedi_language_server",
}
local lsp_opts = {}

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
lsp_opts["clangd"]["root_dir"] = function(fname)
    return util.root_pattern("compile_flags.txt")(fname) or util.path.dirname(fname)
end

lsp_opts["pyright"]["root_dir"] = function(fname)
    return util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or util.path.dirname(fname)
end

-- lsp_opts["jedi_language_server"]["root_dir"] = function(fname)
--     return util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or util.path.dirname(fname)
-- end

-- Loop through the servers listed above.
for _, server_name in pairs(servers) do
    local opts = lsp_opts[server_name]
    require('lspconfig')[server_name].setup(opts)
end
