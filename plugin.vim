let s:plugin_conf_path="$VIM_CONFIG_DIR/plugins"
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', '*.wiki']
let g:indentLine_fileTypeExclude = ['vimwiki']
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'vimwiki']

let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnips"]
" execute printf('source %s/nvim-cmp.vim', s:plugin_conf_path)
