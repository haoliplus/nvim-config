#! /bin/sh
#
# install.sh
# Copyright (C) 2022 lihao <haoliplus@gmail.com>
#
# Distributed under terms of the MIT license.
#

set -x

mkdir -p ${HOME}/.local/share
mkdir -p ${HOME}/.local/bin
mkdir -p ${HOME}/.local/lib
mkdir -p ${HOME}/.local/opt
mkdir -p ${HOME}/.local/include

CACHE_DIR=$(mktemp -d)
NODE_VERSION="v16.13.1"
NVIM_VERSION="v0.6.1"

smv() {
  rm -rf "$2.old"
  mv "$2" "$2.old" >/dev/null 2>&1
  mv "$1" "$2"
}

curl -L https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux64.tar.gz | tar -xz -C ${CACHE_DIR}
smv ${CACHE_DIR}/nvim-linux64/bin/nvim ${HOME}/.local/bin/nvim
smv ${CACHE_DIR}/nvim-linux64/lib/nvim ${HOME}/.local/lib/nvim
smv ${CACHE_DIR}/nvim-linux64/share/nvim ${HOME}/.local/share/nvim
sh -c 'curl -fLo ${HOME}/.local/share/nvim/runtime/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

curl -L https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz | tar -xJ -C ${CACHE_DIR}
smv ${CACHE_DIR}/node-${NODE_VERSION}-linux-x64 ${HOME}/.local/opt/node-${NODE_VERSION}-linux-x64
rm -rf ${HOME}/.local/bin/node && ln -s ${HOME}/.local/opt/node-${NODE_VERSION}-linux-x64/bin/node ${HOME}/.local/bin/node
rm -rf ${HOME}/.local/bin/npm && ln -s ${HOME}/.local/opt/node-${NODE_VERSION}-linux-x64/bin/npm ${HOME}/.local/bin/npm
python3 -m pip install -i https://pypi.douban.com/simple pynvim



CACHE_DIR=$(mktemp -d)

wget -c -o ${CACHE_DIR}/download_${USER}_log https://github.com/haoliplus/nvim-config/archive/refs/heads/master.zip  -O ${CACHE_DIR}/master.zip \
  && unzip ${CACHE_DIR}/master.zip -d ${CACHE_DIR} \
  && cp -r ${CACHE_DIR}/nvim-config-master ${HOME}/nvim


cat >> ${HOME}/.zshrc << 'endmsg'
export PATH="${HOME}/.local/bin:${PATH}"
export VIM_RESOURCE_DIR=${VIM_RESOURCE_DIR:-"${HOME}/.local/share/nvim"}
export VIM_CONFIG_DIR=${VIM_CONFIG_DIR:-"${HOME}/nvim"}
export WIKI_PATH="${HOME}/vimwiki"

export VIMPLUGDIR="${VIM_RESOURCE_DIR}/plugged"
export VIMRUNTIME="${VIM_RESOURCE_DIR}/runtime"
export MYVIMRC=${MYVIMRC:-"${VIM_CONFIG_DIR}/init.vim"}
export VIMINIT='source $MYVIMRC'
alias vim='nvim'
ZSH_THEME="ys"
endmsg

# For current env
export PATH="${HOME}/.local/bin:${PATH}"
export VIM_RESOURCE_DIR=${VIM_RESOURCE_DIR:-"${HOME}/.local/share/nvim"}
export VIM_CONFIG_DIR=${VIM_CONFIG_DIR:-"${HOME}/nvim"}
export WIKI_PATH="${HOME}/vimwiki"

export VIMPLUGDIR="${VIM_RESOURCE_DIR}/plugged"
export VIMRUNTIME="${VIM_RESOURCE_DIR}/runtime"
export MYVIMRC=${MYVIMRC:-"${VIM_CONFIG_DIR}/init.vim"}
export VIMINIT='source $MYVIMRC'
alias vim='nvim'
nvim +PluginInstall +qall

