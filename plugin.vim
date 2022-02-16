let s:plugin_conf_path="$VIM_CONFIG_DIR/plugins"

if executable("CocActionAsync")
  execute printf('source %s/coc.vim', s:plugin_conf_path)
endif
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" execute printf('source %s/nvim-cmp.vim', s:plugin_conf_path)
