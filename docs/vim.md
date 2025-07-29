
Relative path of script file:
`let s:path = expand('<sfile>')`

Absolute path of script file:
`let s:path = expand('<sfile>:p')`

Absolute path of script file with symbolic links resolved:
`let s:path = resolve(expand('<sfile>:p'))`

Folder in which script resides: (not safe for symlinks)
`let s:path = expand('<sfile>:p:h')`

