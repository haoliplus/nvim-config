
return {
    'haoliplus/vimwiki',
    enabled=false,
    config = function()
      vim.g.vimwiki_list = {
        {
          path= vim.g.wiki_path .. '/text/',
          index='Home',
          path_html= vim.g.wiki_path..'/html/',
          syntax= 'markdown',
          inner_link_syntax= 'mediawiki',
          ext= '.md',
          auto_diary_index= 1,
          diary_rel_path= 'summary/diary/',
          auto_generate_links= 1,
          template_path= vim.g.wiki_path .. '/templates/',
          template_default= 'def_template',
          template_ext= '.html'
        }
      }
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown',
      }
      vim.g.vimwiki_hl_headers = 1
      vim.g.vimwiki_global_ext = 0
      vim.cmd([[
        autocmd BufNewFile,BufRead */vimwiki/**.md :autocmd TextChanged,TextChangedI <buffer> silent write
      ]])
    end
  }
