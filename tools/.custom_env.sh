
LOCAL_DIR="${HOME}/.local"
VIM_CONFIG_DIR="${HOME}/.dotfiles/nvim"
export VIM_CONFIG_DIR="${VIM_CONFIG_DIR}"
export HISTFILE="${HOME}/.cache/.docker_zsh_history"
export PATH="${LOCAL_DIR}/bin:${PATH}"
export VIM_RESOURCE_DIR=${VIM_RESOURCE_DIR:-"${LOCAL_DIR}/share/nvim"}
export WIKI_PATH="${HOME}/vimwiki"

export VIMPLUGDIR="${VIM_RESOURCE_DIR}/plugged"
export VIMRUNTIME="${VIM_RESOURCE_DIR}/runtime"
export MYVIMRC=${MYVIMRC:-"${VIM_CONFIG_DIR}/init.vim"}
export VIMINIT='source $MYVIMRC'
export TERM="xterm-256color"
export LS_COLORS="rs=0:di=01;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:"\
"bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:"\
"ow=40;33;01:st=37;44:ex=01;32:*Makefile=20;33:"
alias vim='nvim'
alias vi='nvim'
alias ninstall='nvim +PlugInstall +qall'
