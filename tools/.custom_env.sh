LOCAL_DIR="${HOME}/.local"
VIM_CONFIG_DIR="${HOME}/.dotfiles/nvim"
export VIM_CONFIG_DIR="${VIM_CONFIG_DIR}"
export PATH="${LOCAL_DIR}/bin:${PATH}"
export VIM_RESOURCE_DIR=${VIM_RESOURCE_DIR:-"${LOCAL_DIR}/share/nvim"}

export VIMPLUGDIR="${VIM_RESOURCE_DIR}/plugged"
export VIMRUNTIME="${VIM_RESOURCE_DIR}/runtime"
export MYVIMRC=${MYVIMRC:-"${VIM_CONFIG_DIR}/init.vim"}
export VIMINIT='source $MYVIMRC'
export TERM="xterm-256color"
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
  export HTTP_PROXY=http://${PROXY_ADDRESS}
  export HTTPS_PROXY=http://${PROXY_ADDRESS}
  export http_proxy=http://${PROXY_ADDRESS}
  export https_proxy=http://${PROXY_ADDRESS}
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
