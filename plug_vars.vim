let s:plugin_conf_path="$VIM_CONFIG_DIR/plugins"

let g:LanguageClient_serverStderr = '/tmp/clangd.stderr'

" VIMWIKI
let g:vimwiki_list = [{'path': g:wiki_path.'/text/',
       \ 'index':'Home',
       \ 'path_html': g:wiki_path.'/html/',
       \ 'syntax': 'markdown',
       \ 'inner_link_syntax': 'mediawiki',
       \ 'ext': '.md',
       \ 'auto_diary_index': 1,
       \ 'diary_rel_path': 'summary/diary/',
       \ 'auto_generate_links': 1,
       \ 'template_path': g:wiki_path.'/templates/',
       \ 'template_default': 'def_template',
       \ 'template_ext': '.html'}]

let g:vimwiki_hl_headers = 1
let g:vimwiki_global_ext = 0

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" Indent Line
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', '*.wiki']
let g:indentLine_fileTypeExclude = ['vimwiki']
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'vimwiki']

" UltiSnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnips"]
" execute printf('source %s/nvim-cmp.vim', s:plugin_conf_path)
