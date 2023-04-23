#! /bin/sh
#
# install.sh
# Copyright (C) 2022 lihao <haoliplus@gmail.com>
#
# Distributed under terms of the MIT license.
#
set -ex

SSH_ALIAS=${SSH_ALIAS:-"guest"}

sync_file() {
  rsync --copy-links -aP $1 ${SSH_ALIAS}:~/$(dirname $1)
}


cd ${HOME}
sync_file .local/bin/nvim
sync_file .local/bin/nvim.appimage
sync_file .local/bin/node
sync_file .local/lib/nvim
sync_file .local/share/nvim
