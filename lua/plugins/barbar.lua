
return {
    'romgrk/barbar.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    enabled=true,
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      -- Move to previous/next
      map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
      map('n', '<Leader>1', '<Cmd>BufferGoto 1<CR>', opts)
      map('n', '<Leader>2', '<Cmd>BufferGoto 2<CR>', opts)
      map('n', '<Leader>3', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '<Leader>4', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '<Leader>5', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '<Leader>6', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '<Leader>7', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '<Leader>8', '<Cmd>BufferGoto 8<CR>', opts)
      map('n', '<Leader>9', '<Cmd>BufferGoto 9<CR>', opts)
      map('n', '<Leader>0', '<Cmd>BufferLast<CR>', opts)
      -- Close buffer
      map('n', '<Leader>c', '<Cmd>BufferClose<CR>', opts)
    end
  }
