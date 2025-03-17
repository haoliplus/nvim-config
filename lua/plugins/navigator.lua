return {
  ---- community-maintained snippets
  {
    "mileszs/ack.vim",
    init = function()
      if vim.fn.executable("ag") == 1 then
        vim.g.ackprg = "ag --vimgrep"
        vim.keymap.set("n", "<Leader>a", ":Ack<Space>", { noremap = true, silent = true, desc = "Ack" })
      end
    end,
  },
  -- jump between .h/.cc
  -- { 'for': {'c', 'cpp'} }
  { "vim-scripts/a.vim", ft = { "c", "cpp", "cc", "cuda" } },
  ---- fuzzy search using c-t
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { -- switch between heading and impl
    "jakemason/ouroboros",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    enabled = false,
    config = function()
      -- these are the defaults, customize as desired
      require("ouroboros").setup({
        extension_preferences_table = {
          -- Higher numbers are a heavier weight and thus preferred.
          -- In the following, .c would prefer to open .h before .hpp
          c = { h = 2, hpp = 1 },
          h = { c = 2, cpp = 1 },
          cpp = { hpp = 2, h = 1 },
          hpp = { cpp = 1, c = 2 },

          -- Ouroboros supports any combination of filetypes you like, simply
          -- add them as desired:
          -- myext = { myextsrc = 2, myextoldsrc = 1},
          -- tpp = {hpp = 2, h = 1},
          -- inl = {cpp = 3, hpp = 2, h = 1},
          -- cu = {cuh = 3, hpp = 2, h = 1},
          -- cuh = {cu = 1}
        },
        -- if this is true and the matching file is already open in a pane, we'll
        -- switch to that pane instead of opening it in the current buffer
        switch_to_open_pane_if_possible = false,
      })
    end,
  },
  {
    "junegunn/fzf",
    build = "./install --all",
    config = function()
      -- Fzf
      -- vim.keymap.set("n", "<F6>", ":Buffers<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<F7>", ":Marks<CR>", { noremap = true, silent = true })
      vim.cmd([[autocmd FileType fzf call feedkeys("i\<Bs>")]])
    end,
  },
  { -- switch between heading and impl
    "jakemason/ouroboros",
    enabled = false,
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      -- these are the defaults, customize as desired
      require("ouroboros").setup({
        extension_preferences_table = {
          -- Higher numbers are a heavier weight and thus preferred.
          -- In the following, .c would prefer to open .h before .hpp
          c = { h = 2, hpp = 1 },
          h = { cc = 3, c = 2, cpp = 1 },
          cpp = { hpp = 2, h = 1 },
          cc = { hpp = 2, h = 1 },
          hpp = { cpp = 1, c = 2 },
          -- tpp = {hpp = 2, h = 1},

          -- Ouroboros supports any combination of filetypes you like, simply
          -- add them as desired:
          -- myext = { myextsrc = 2, myextoldsrc = 1},
          -- tpp = {hpp = 2, h = 1},
          -- inl = {cpp = 3, hpp = 2, h = 1},
          -- cu = {cuh = 3, hpp = 2, h = 1},
          -- cuh = {cu = 1}
        },
        -- if this is true and the matching file is already open in a pane, we'll
        -- switch to that pane instead of opening it in the current buffer
        switch_to_open_pane_if_possible = false,
      })
      vim.cmd([[autocmd! Filetype c,cpp map<buffer> <C-e> :Ouroboros<CR>]])
      -- vim.keymap.set('cno', 'A', 'Ouroboros')
    end,
  },
  --{
  --	"ctrlpvim/ctrlp.vim",
  --	init = function()
  --		vim.g.ctrlp_working_path_mode = 0
  --		vim.g.ctrlp_max_height = 20
  --		vim.g.ctrlp_custom_ignore = "node_modules|^.DS_Store|^.git|^.coffee"
  --		--"""""""""""""""""""""""""""""
  --		-- => CTRL-P
  --		--"""""""""""""""""""""""""""""
  --		vim.g.ctrlp_map = "<c-f>"
  --	end,
  --},
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    submodules = false,
    -- or                            , branch = '0.1.x',
    dependencies = { { "nvim-lua/plenary.nvim" }, { "crusj/bookmarks.nvim" } },
    config = function()
      require("telescope").setup({
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-i>"] = "which_key",
            },
          },
          initial_mode = "normal",
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- find_template = {
          -- },
          -- please take a look at the readme of the extension you want to configure
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("bookmarks")
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find_files" })
      vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "quickfix" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "live_grep" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "oldfiles" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "help_tags" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "diagnostics" })
      -- vim.keymap.set("n", "<leader>fm", builtin.marks, {})
      vim.keymap.set("n", "<leader>fm", ":Telescope bookmarks<CR>", { desc = "bookmarks" })
      vim.keymap.set("n", "<leader>ft", builtin.tags, { desc = "tags" })
      vim.keymap.set("n", "<c-f>", builtin.find_files, { desc = "find_files" })
      -- vim.keymap.set("n", "<F6>", ":Buffers<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<F7>", ":Marks<CR>", { noremap = true, silent = true })
      --		vim.g.ctrlp_map = "<c-f>"
    end,
  },
  {
    "crusj/bookmarks.nvim",
    keys = {
      { "<Leader><tab>", mode = { "n" } },
    },
    branch = "main",
    dependencies = { "nvim-web-devicons" },
    config = function()
      require("bookmarks").setup({
        storage_dir = "", -- Default path: vim.fn.stdpath("data").."/bookmarks,  if not the default directory, should be absolute path",
        mappings_enabled = true, -- If the value is false, only valid for global keymaps: toggle、add、delete_on_virt、show_desc
        keymap = {
          toggle = "<Leader><tab>", -- Toggle bookmarks(global keymap)
          close = "q", -- close bookmarks (buf keymap)
          add = "\\z", -- Add bookmarks(global keymap)
          add_global = "\\g", -- Add global bookmarks(global keymap), global bookmarks will appear in all projects. Identified with the symbol '󰯾'
          jump = "<CR>", -- Jump from bookmarks(buf keymap)
          delete = "dd", -- Delete bookmarks(buf keymap)
          order = "<space><space>", -- Order bookmarks by frequency or updated_time(buf keymap)
          delete_on_virt = "\\dd", -- Delete bookmark at virt text line(global keymap)
          show_desc = "\\sd", -- show bookmark desc(global keymap)
          focus_tags = "<c-j>", -- focus tags window
          focus_bookmarks = "<c-k>", -- focus bookmarks window
          toogle_focus = "<S-Tab>", -- toggle window focus (tags-window <-> bookmarks-window)
        },
        width = 0.8, -- Bookmarks window width:  (0, 1]
        height = 0.7, -- Bookmarks window height: (0, 1]
        preview_ratio = 0.45, -- Bookmarks preview window ratio (0, 1]
        tags_ratio = 0.1, -- Bookmarks tags window ratio
        fix_enable = false, -- If true, when saving the current file, if the bookmark line number of the current file changes, try to fix it.

        virt_text = "", -- Show virt text at the end of bookmarked lines, if it is empty, use the description of bookmarks instead.
        sign_icon = "󰃃", -- if it is not empty, show icon in signColumn.
        virt_pattern = { "*.go", "*.lua", "*.sh", "*.php", "*.rs" }, -- Show virt text only on matched pattern
        virt_ignore_pattern = {}, -- Ignore showing virt text on matched pattern, this works after virt_pattern
        border_style = "single", -- border style: "single", "double", "rounded"
        hl = {
          border = "TelescopeBorder", -- border highlight
          cursorline = "guibg=Gray guifg=White", -- cursorline highlight
        },
        datetime_format = "%Y-%m-%d %H:%M:%S", -- os.date
        -- •	%Y: Four-digit year
        -- •	%m: Two-digit month (01 to 12)
        -- •	%d: Two-digit day (01 to 31)
        -- •	%H: Hour in 24-hour format (00 to 23)
        -- •	%I: Hour in 12-hour format (01 to 12)
        -- •	%M: Two-digit minute (00 to 59)
        -- •	%S: Two-digit second (00 to 59)
        -- •	%p: AM/PM indicator
      })
      -- require("telescope").load_extension("bookmarks")
    end,
  },
}
