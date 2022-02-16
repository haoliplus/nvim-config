" Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    let t:NERDTreeTabLastWindow = winnr()
    silent! NERDTreeFind
    NERDTreeFocus
    exec t:NERDTreeTabLastWindow . "wincmd w"
  endif
endfunction

" function! NearestMethodOrFunction() abort
"   try
"     return get(b:, 'vista_nearest_method_or_function', '')
"   catch
"     return '---'
"   endtry
" endfunction

