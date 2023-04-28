#! /bin/sh
#
# install.sh
# Copyright (C) 2022 lihao <haoliplus@gmail.com>
#
# Distributed under terms of the MIT license.
#
set -ex

SSH_ALIAS=${SSH_ALIAS:-"guest"}
PORT=${PORT:-"22"}

sync_file() {
  rsync -e "ssh -p ${PORT}" --copy-links -aP $1 ${SSH_ALIAS}:~/$(dirname $1)
}


cd ${HOME}
ssh ${SSH_ALIAS} -p ${PORT} "mkdir -p ~/.local/bin; mkdir -p ~/.local/lib; mkdir -p ~/.local/share;mkdir -p ~/.dotfiles"
sync_file .dotfiles/nvim
sync_file .local/bin/nvim.bin
sync_file .local/bin/nvim.appimage
sync_file .local/bin/node
sync_file .local/lib/nvim
sync_file .local/share/nvim

ssh ${SSH_ALIAS} -p ${PORT} "echo 'source ${HOME}/.dotfiles/nvim/tools/.custom_env.sh'  >> ${HOME}/.zshrc"
ssh ${SSH_ALIAS} -p ${PORT} "echo 'source ${HOME}/.dotfiles/nvim/tools/.custom_env.sh'  >> ${HOME}/.bashrc"


ssh ${SSH_ALIAS} -p ${PORT} '${HOME}/.local/bin/nvim.bin --version &> /dev/null && ln -sfn ${HOME}/.local/bin/nvim.bin ${HOME}/.local/bin/nvim || ln -s ${HOME}/.local/bin/nvim.appimage ${HOME}/.local/bin/nvim'
