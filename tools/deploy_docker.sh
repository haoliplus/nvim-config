#! /bin/sh
#
# install.sh
# Copyright (C) 2022 lihao <haoliplus@gmail.com>
#
# Distributed under terms of the MIT license.
#
set -ex

sync_file() {
  docker exec  -it ${CONTAINER} mkdir -p /home/${USER}/$(dirname $1)/
  docker cp -L  $1 ${CONTAINER}:/home/${USER}/$(dirname $1)/
}

docker exec  -it ${CONTAINER} sudo apt update
docker exec  -it ${CONTAINER} sudo apt install -y ninja-build gettext cmake unzip curl
docker exec -w /home/${USER} -it ${CONTAINER} git clone https://github.com/neovim/neovim
docker exec -w /home/${USER} -it ${CONTAINER} git checkout v0.8.3
docker exec -w /home/${USER} -it ${CONTAINER} make
docker exec -w /home/${USER} -it ${CONTAINER} sudo make install

cd ${HOME}
sync_file .dotfiles/nvim
sync_file .local/bin/nvim.bin
sync_file .local/bin/nvim.appimage
sync_file .local/bin/node
sync_file .local/lib/nvim
sync_file .local/share/nvim
