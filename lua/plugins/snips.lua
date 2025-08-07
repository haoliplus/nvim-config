return {
  {
    "nvimdev/template.nvim",
    dependencies = { { "nvim-telescope/telescope.nvim" } },
    -- this allow us to load this plugin only when we type this command.
    -- But this makes the config ineffect sometimes
    -- cmd = {'Template','TemProject'},
    config = function()
      -- vim.filetype.add ( filename = { ['main.sh'] = 'sh' })
      -- vim.filetype.add ( filename = { ['default.makefile'] = 'make' })

      require("template").setup({
        temp_dir = vim.g.config_path .. "/templates",
        author = vim.fn.getenv("NICKNAME"), -- your name
        email = vim.fn.getenv("MAIL"), -- email address
      })
      -- vim.keymap.set('n', '<F10>', ':Template ',  { remap = true})
      require("telescope").load_extension("find_template")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    submodules = false,
    -- build = "make install_jsregexp",
    -- install jsregexp (optional!).
    -- sudo apt install libluajit-5.1-dev
    -- this sometimes cause fatal error
    -- build = "make install_jsregexp",
    dependencies = { "haoliplus/friendly-snippets" },
    config = function()
      -- press <Tab> to expand or jump in a snippet. These can also be mapped separately
      -- via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
      vim.cmd([[imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' ]])
      -- -1 for jumping backwards.
      vim.cmd([[inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>]])

      vim.cmd([[snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>]])
      vim.cmd([[snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>]])

      -- For changing choices in choiceNodes (not strictly necessary for a basic setup).
      vim.cmd([[imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']])
      vim.cmd([[smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']])
      ----------------------------------------------------------------------------------------------------------------
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snips/vscode" } })
      -- require("luasnip.loaders.from_vscode").lazy_load()
      -- require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snips/snipmate/mine" } })
      -- require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snips/snipmate/ulti" } })
      -- require("luasnip.loaders.from_lua").load({
      --   paths = {
      --     "./lua/luasnip_snippets/snippets"
      --   },
      -- })
      -- local community_snippets = require("luasnip_snippets").load_snippets()
      -- for k, v in pairs(community_snippets) do
      --   ls.add_snippets(k, v)
      -- end
      ----------------------------------------------------------------------------------------------------------------
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      -- local sn = ls.snippet_node
      -- local f = ls.function_node
      -- local d = ls.dynamic_node
      -- local c = ls.choice_node
      ls.add_snippets("all", {
        s("sample", {
          -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
          i(1, "cosssssnd"),
          t(" ? "),
          i(2, "then"),
          t(" : "),
          i(3, "else"),
        }),
      })
    end,
  },
}
