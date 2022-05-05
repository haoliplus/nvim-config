#! /bin/sh
#
# install.sh
# Copyright (C) 2022 lihao <haoliplus@gmail.com>
#
# Distributed under terms of the MIT license.
#

set -ex

CACHE_DIR=$(mktemp -d)
NODE_VERSION="v16.13.1"
NVIM_VERSION="v0.6.1"
NVIM_ROOT=${HOME}/.nvim

export CURRENT_OS=$(uname)
export OS=$(uname)

if [[ "$OS" == 'Linux' ]]; then
  NVIM_NAME="nvim-linux64"
  NODE_NAME="linux-x64"
elif [[ "$OS" == 'Darwin' ]]; then
  NVIM_NAME="nvim-macos"
  NODE_NAME="darwin-arm64"
fi

smv() {
  rm -rf "$2.old"
  mv "$2" "$2.old" >/dev/null 2>&1 || true
  mv "$1" "$2"
}
create_link() {
  rm -rf "$2.old"
  mv "$2" "$2.old" >/dev/null 2>&1 || true
  ln -s "$1" "$2" && return 0
}

mkdir -p ${HOME}/.local/share
mkdir -p ${HOME}/.local/bin
mkdir -p ${HOME}/.local/lib
mkdir -p ${HOME}/.local/opt
mkdir -p ${HOME}/.local/include
mkdir -p ${HOME}/.cache/temp_dirs/undodir

curl -L https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_NAME}.tar.gz | tar -xz -C ${CACHE_DIR}
sh -c 'curl -fLo ${HOME}/.local/share/nvim/runtime/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

curl -L https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_NAME}.tar.xz | tar -xJ -C ${CACHE_DIR}

wget -c -o ${CACHE_DIR}/download_${USER}_log https://github.com/haoliplus/nvim-config/archive/refs/heads/master.zip  -O ${CACHE_DIR}/master.zip \
  && unzip ${CACHE_DIR}/master.zip -d ${CACHE_DIR} \
  && smv "${CACHE_DIR}/nvim-config-master" "${NVIM_ROOT}"

python3 -m pip install -i https://pypi.douban.com/simple pynvim pyright black yapf

smv ${CACHE_DIR}/${NVIM_NAME}/bin/nvim ${HOME}/.local/bin/nvim
smv ${CACHE_DIR}/${NVIM_NAME}/lib/nvim ${HOME}/.local/lib/nvim
smv ${CACHE_DIR}/${NVIM_NAME}/share/nvim ${HOME}/.local/share/nvim
smv ${CACHE_DIR}/node-${NODE_VERSION}-${NODE_NAME} ${HOME}/.local/opt/node-${NODE_VERSION}-${NODE_NAME}

create_link "${HOME}/.local/opt/node-${NODE_VERSION}-${NODE_NAME}/bin/node" "${HOME}/.local/bin/node"
create_link "${HOME}/.local/opt/node-${NODE_VERSION}-${NODE_NAME}/bin/npm" "${HOME}/.local/bin/npm"

create_link "${NVIM_ROOT}/resources/.tmux.conf" "${HOME}/.tmux.conf"
create_link "${NVIM_ROOT}/resources/.tmux.conf.local" "${HOME}/.tmux.conf.local"
create_link "${NVIM_ROOT}/resources/.flake8" "${HOME}/.flake8"
create_link "${NVIM_ROOT}/resources/pycodestyle" "${HOME}/.config/pycodestyle"
create_link "${NVIM_ROOT}/resources/yapf" "${HOME}/.config/yapf"

cat >> ${HOME}/.zshrc << 'endmsg'
export PATH="${HOME}/.local/bin:${PATH}"
export VIM_RESOURCE_DIR=${VIM_RESOURCE_DIR:-"${HOME}/.local/share/nvim"}
export VIM_CONFIG_DIR=${VIM_CONFIG_DIR:-"${HOME}/.nvim"}
export WIKI_PATH="${HOME}/vimwiki"

export VIMPLUGDIR="${VIM_RESOURCE_DIR}/plugged"
export VIMRUNTIME="${VIM_RESOURCE_DIR}/runtime"
export MYVIMRC=${MYVIMRC:-"${VIM_CONFIG_DIR}/init.vim"}
export VIMINIT='source $MYVIMRC'
export TERM="xterm-256color"
alias vim='nvim'
alias vi='nvim'
alias ninstall='nvim +PlugInstall +qall'
ZSH_THEME="ys"
endmsg

echo "source ~/.zshrc"
