
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

mv ${HOME}/.tmux.conf ${HOME}/.tmux.conf.old || true
mv ${HOME}/.tmux.conf.local ${HOME}/.tmux.conf.local.old || true
ln -s ${HOME}/.dotfiles/nvim/resources/.tmux.conf ${HOME}/.tmux.conf
ln -s ${HOME}/.dotfiles/nvim/resources/.tmux.conf.local ${HOME}/.tmux.conf.local

function setproxy() {
  if [[ -z "$1" ]]; then
    read PROXY_ADDRESS
  else
    PROXY_ADDRESS="$1"
  fi
  echo "Proxy address: ${PROXY_ADDRESS}"
  export HTTP_PROXY=http://${PROXY_ADDRESS}:7890
  export HTTPS_PROXY=http://${PROXY_ADDRESS}:7890
  export http_proxy=http://${PROXY_ADDRESS}:7890
  export https_proxy=http://${PROXY_ADDRESS}:7890
  NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.39.0/24,192.168.49.0/24
  no_proxy=localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.39.0/24,192.168.49.0/24
}
function activate_ssh() {
  # SSH_AUTH_SOCK
  # SSH_AGENT_PID
  eval `ssh-agent -s`
  if [[ "$OS" == 'Linux' ]]; then
    ssh-add
  elif [[ "$OS" == 'Darwin' ]]; then
    ssh-add --apple-use-keychain --apple-load-keychain
  fi
}
