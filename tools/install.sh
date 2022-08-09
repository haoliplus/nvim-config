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
# NVIM_VERSION="v0.6.1"
NVIM_VERSION="stable"
NVIM_ROOT=${HOME}/.nvim
DOTROOT="${DOTROOT:=${HOME}/.dotfiles}"
mkdir -p ${HOME}/.cache/temp_dirs/undodir

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
curl -L https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_NAME}.tar.xz | tar -xJ -C ${CACHE_DIR}

smv ${CACHE_DIR}/${NVIM_NAME}/bin/nvim ${HOME}/.local/bin/nvim
smv ${CACHE_DIR}/${NVIM_NAME}/lib/nvim ${HOME}/.local/lib/nvim
smv ${CACHE_DIR}/${NVIM_NAME}/share/nvim ${HOME}/.local/share/nvim

PLUG_FILE=${HOME}/.local/share/nvim/runtime/autoload/plug.vim
while [ ! -f ${PLUG_FILE} ]
do
  curl -fLo  ${PLUG_FILE} --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
done

smv ${CACHE_DIR}/node-${NODE_VERSION}-${NODE_NAME} ${HOME}/.local/opt/node-${NODE_VERSION}-${NODE_NAME}

create_link "${HOME}/.local/opt/node-${NODE_VERSION}-${NODE_NAME}/bin/node" "${HOME}/.local/bin/node"
create_link "${HOME}/.local/opt/node-${NODE_VERSION}-${NODE_NAME}/bin/npm" "${HOME}/.local/bin/npm"

if [[ ! -f ${DOTROOT} ]] || [[ ! -f ${DOTROOT}/home/config/nvim ]]; then
  wget -c -o ${CACHE_DIR}/download_${USER}_log https://github.com/haoliplus/nvim-config/archive/refs/heads/master.zip  -O ${CACHE_DIR}/master.zip \
    && unzip ${CACHE_DIR}/master.zip -d ${CACHE_DIR} \
    && smv "${CACHE_DIR}/nvim-config-master" "${NVIM_ROOT}"
fi

python3 -m pip install -i https://pypi.douban.com/simple pynvim pyright black yapf

create_link "${NVIM_ROOT}/resources/.tmux.conf" "${HOME}/.tmux.conf"
create_link "${NVIM_ROOT}/resources/.tmux.conf.local" "${HOME}/.tmux.conf.local"
create_link "${NVIM_ROOT}/resources/.flake8" "${HOME}/.flake8"
create_link "${NVIM_ROOT}/resources/pycodestyle" "${HOME}/.config/pycodestyle"
create_link "${NVIM_ROOT}/resources/yapf" "${HOME}/.config/yapf"
create_link "${NVIM_ROOT}/resources/clang-format" "${HOME}/.clang-format"

if [[ ! -f ${DOTROOT} ]]; then
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
  export LS_COLORS="rs=0:di=01;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=40;33;01:st=37;44:ex=01;32:*Makefile=20;33:*.py=01;32:*.md=01;31:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"
  alias vim='nvim'
  alias vi='nvim'
  alias ninstall='nvim +PlugInstall +qall'
  ZSH_THEME="ys"
endmsg

fi

echo "source ~/.zshrc"

