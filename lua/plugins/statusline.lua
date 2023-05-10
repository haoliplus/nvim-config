
return {-- status bar
  {'itchyny/lightline.vim',
    dependencies = {
      'mengelbrecht/lightline-bufferline',
      'akinsho/bufferline.nvim'
    },
    setup = function()
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
  ---- show indent line
  {'Yggdroot/indentLine',
    setup = function()
      -- Indent Line
      vim.g.indentLine_bufNameExclude = {'_.*', 'NERD_tree.*', '*.wiki'}
      vim.g.indentLine_fileTypeExclude = {'vimwiki'}
      vim.g.indentLine_bufTypeExclude = {'help', 'terminal', 'vimwiki'}
      vim.g.indentLine_color_term = 239
    end
  }
}
