
return {
    'google/vim-codefmt',
    enabled=function() return jit.os ~= "Windows" end,
    dependencies = {
      'google/vim-glaive',
      'google/vim-maktaba'
    },
    config = function()
      vim.cmd('call glaive#Install()')
      -- FileType
      vim.cmd([[
        autocmd FileType c,cpp,proto,javascript  let b:codefmt_formatter = 'clang-format'
        autocmd FileType bzl let b:codefmt_formatter = 'buildifier'
        autocmd FileType python let b:codefmt_formatter = 'black'
      ]])
      -- Only format manually
      vim.cmd(
        [[
        autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
      ]])
    end
  }
