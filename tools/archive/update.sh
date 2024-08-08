#! /bin/sh
#
# install.sh
# Copyright (C) 2022 lihao <haoliplus@gmail.com>
#
# Distributed under terms of the MIT license.
#
set -x

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
export CURRENT_OS=$(uname)
export OS=$(uname)

if [[ "$OS" == 'Linux' ]]; then
  NVIM_NAME="nvim-linux64"
  NODE_NAME="linux-x64"
elif [[ "$OS" == 'Darwin' ]]; then
  NVIM_NAME="nvim-macos"
  NODE_NAME="darwin-arm64"
fi

TMP_DIR=$(mktemp -d)
NODE_VERSION="v16.13.1"
# NVIM_VERSION="v0.6.1"
# NVIM_VERSION>=v0.8.0 requires glibc
# NVIM_VERSION="stable"
DOTROOT=${DOTROOT:-"${HOME}/.dotfiles"}

if [[ -d "${DOTROOT}/nvim" ]] ; then
  VIM_CONFIG_DIR="${DOTROOT}/nvim"
  LOCAL_DIR="${HOME}/.local"
  NVIM_VERSION="v0.8.3"
else
  PERSISTENT_DIR="${HOME}/.cache"
  VIM_CONFIG_DIR="${PERSISTENT_DIR}/.nvim"
  LOCAL_DIR="${PERSISTENT_DIR}/.local"
  NVIM_VERSION="v0.7.2"
fi

SHARE_DIR="${LOCAL_DIR}/share"
BIN_DIR="${LOCAL_DIR}/bin"
LIB_DIR="${LOCAL_DIR}/lib"
OPT_DIR="${LOCAL_DIR}/opt"
INCLUDE_DIR="${LOCAL_DIR}/include"
CACHE_DIR="${LOCAL_DIR}/.cache"

NODE_DIR="node-${NODE_VERSION}-${NODE_NAME}"

NVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_NAME}.tar.gz"
PLUG_VIM_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
# https://registry.npmmirror.com/-/binary/node/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_NAME}.tar.xz
# https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_NAME}.tar.xz
NODE_DOWNLOAD_URL="https://registry.npmmirror.com/-/binary/node/${NODE_VERSION}/${NODE_DIR}.tar.xz"
NVIM_CONFIG_URL="https://github.com/haoliplus/nvim-config/archive/refs/heads/master.zip"

if [[ ! -d "${DOTROOT}/nvim" ]] && [[ ! -d ${VIM_CONFIG_DIR} ]] ; then
  wget -c ${NVIM_CONFIG_URL}  -O ${TMP_DIR}/master.zip \
    && unzip ${TMP_DIR}/master.zip -d ${TMP_DIR} \
    && smv "${TMP_DIR}/nvim-config-master" "${VIM_CONFIG_DIR}"
fi

# curl -L ${NVIM_DOWNLOAD_URL} | tar -xz -C ${TMP_DIR}
wget -O - -c ${NVIM_DOWNLOAD_URL} | tar -xz -C ${TMP_DIR}
smv ${TMP_DIR}/${NVIM_NAME}/bin/nvim ${LOCAL_DIR}/bin/nvim
smv ${TMP_DIR}/${NVIM_NAME}/lib/nvim ${LOCAL_DIR}/lib/nvim
smv ${TMP_DIR}/${NVIM_NAME}/share/nvim ${LOCAL_DIR}/share/nvim

PLUG_FILE=${LOCAL_DIR}/share/nvim/runtime/autoload/plug.vim
wget -O ${PLUG_FILE} -c ${PLUG_VIM_URL}

# curl -L ${NODE_DOWNLOAD_URL} | tar -xJ -C ${TMP_DIR}
curl -L ${NODE_DOWNLOAD_URL} | tar -xJ -C ${TMP_DIR}
smv ${TMP_DIR}/${NODE_DIR} ${LOCAL_DIR}/opt/${NODE_DIR}

