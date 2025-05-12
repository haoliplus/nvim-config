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
  NVIM_NAME="nvim-linux-x86_64"
elif [[ "$OS" == 'Darwin' ]]; then
  NVIM_NAME="nvim-macos-arm64"
fi

NVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/latest/download/${NVIM_NAME}.tar.gz"

TMP_DIR=$(mktemp -d)
LOCAL_DIR="${HOME}/.local"

SHARE_DIR="${LOCAL_DIR}/share"
BIN_DIR="${LOCAL_DIR}/bin"
LIB_DIR="${LOCAL_DIR}/lib"
mkdir -p ${LIB_DIR}
mkdir -p ${BIN_DIR}
mkdir -p ${SHARE_DIR}

# curl -L ${NVIM_DOWNLOAD_URL} | tar -xz -C ${TMP_DIR}
wget -O - -c ${NVIM_DOWNLOAD_URL} | tar -xz -C ${TMP_DIR}
echo ${TMP_DIR}

smv ${TMP_DIR}/${NVIM_NAME}/bin/nvim ${LOCAL_DIR}/bin/nvim
smv ${TMP_DIR}/${NVIM_NAME}/lib/nvim ${LOCAL_DIR}/lib/nvim
smv ${TMP_DIR}/${NVIM_NAME}/share/nvim/runtime ${LOCAL_DIR}/share/nvim/runtime

