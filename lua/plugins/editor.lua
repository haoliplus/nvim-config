return {
  { "yioneko/nvim-yati", dependencies = "nvim-treesitter/nvim-treesitter" },
  { -- 切换buffer时禁止自动滚动
    "BranimirE/fix-auto-scroll.nvim",
    event = "VeryLazy",
    enabled = true,
  },
  -- quick commentary
  -- { "tpope/vim-commentary" },
  { -- better comment cmd
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
      ---Add a space b/w comment and the line
      padding = true,
      ---Whether the cursor should stay at its position
      sticky = true,
      ---Lines to be ignored while (un)comment
      ignore = nil,
      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        ---Line-comment toggle keymap
        line = "gcc",
        ---Block-comment toggle keymap
        block = "gbc",
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = "gc",
        ---Block-comment keymap
        block = "gb",
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = "gcO",
        ---Add comment on the line below
        below = "gco",
        ---Add comment at the end of line
        eol = "gcA",
      },
      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
      ---Function to call before (un)comment
      pre_hook = nil,
      ---Function to call after (un)comment
      post_hook = nil,
    },
    lazy = false,
    config = function(opts)
      -- vim.cmd([[autocmd FileType cpp setlocal commentstring=///\ %s]])
      -- vim.cmd([[autocmd FileType cuda setlocal commentstring=///\ %s]])
      local ft = require("Comment.ft")
      -- 2. Metatable magic
      ft.javascript = { "//%s", "/*%s*/" }
      ft.yaml = "#%s"
      ft({ "cuda", "cpp" }, { "///%s", "/**%s**/" })

      require("Comment").setup(opts)
    end,
  },
  { -- add sudo command
    "lambdalisue/suda.vim",
  },
  -- {'google/vim-glaive', dependencies = {'google/vim-maktaba' }},
  ---- motions to surround text with other text
  {
    --- surr*ound_words             ysiw)           (surround_words)
    -- *make strings               ys$"            "make strings"
    -- [delete ar*ound me!]        ds]             delete around me!
    -- remove <b>HTML t*ags</b>    dst             remove HTML tags
    -- 'change quot*es'            cs'"            "change quotes"
    -- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    -- delete(functi*on calls)     dsf             function calls
    "kylechui/nvim-surround",
    opts = {},
  },
  -- automatically insert/delete parenthesis, brackets, quotes
  { -- autopairs
    "windwp/nvim-autopairs",
    opts = {},
  },
}
