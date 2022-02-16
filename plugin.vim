let s:plugin_conf_path="$VIM_CONFIG_DIR/plugins"

if executable("CocActionAsync")
  execute printf('source %s/coc.vim', s:plugin_conf_path)
endif

" execute printf('source %s/nvim-cmp.vim', s:plugin_conf_path)
