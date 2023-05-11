
return {-- status bar
  {'itchyny/lightline.vim',
    dependencies = {
      'mengelbrecht/lightline-bufferline',
      'akinsho/bufferline.nvim'
    },
    init = function()
      vim.g.lightline = {
        colorscheme = 'one',
        active = {
          left = {
            {'filename', 'gitbranch', 'mode'},
            {'readonly', 'paste', 'modified'}
          },
          right= {
            {'lineinfo', 'percent' },
            -- 'fileformat', 'fileencoding',
            {'filetype', 'charvaluehex' }
          }
        },
        component_function = {
          gitbranch = 'FugitiveHead',
        },
        component_expand = {
          buffers = 'lightline#bufferline#buffers'
        },
        component_type = {
          buffers = 'tabsel'
        }
      }
    end
  },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        config = {
          packages = { enable = true }, -- show how many plugins neovim loaded
          mru = { limit = 10, icon = '* ', label = 'Recent Files', },
          footer = {"hello"}, -- footer
          -- limit how many projects list, action when you press key or enter it will run this action.
          -- action can be a functino type, e.g.
          -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
          project = { enable = true, limit = 8, icon = '- ', label = 'Recent Project' },
        },
      }
    end,
    dependencies = {'nvim-tree/nvim-web-devicons'}
  },
}
