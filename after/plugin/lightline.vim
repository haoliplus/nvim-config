let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ ['filename', 'readonly', 'gitbranch', 'paste', 'mode'],
      \             ['method', 'cocstatus', 'modified']]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'fugitive#head',
      \   'method': 'NearestMethodOrFunction',
      \ },
      \ }

