#!/usr/bin/env sh

######################################################################
# @author      : lihao (lihao@fabu.ai)
# @file        : env
# @created     : Wednesday Mar 01, 2023 10:03:45 CST
#
# @description : 
######################################################################

LOCAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export DOTROOT="${DOTROOT:-${HOME}/.dotfiles}"
# tar zxf nvim-linux64.tar.gz -C ${HOME}/.local/opt/
export VIM_RESOURCE_DIR=${VIM_RESOURCE_DIR:-"${HOME}/.local/share/nvim"}
export VIM_CONFIG_DIR=${VIM_CONFIG_DIR:-"${DOTROOT}/nvim"}
export WIKI_PATH="${HOME}/vimwiki"

export VIMPLUGDIR="${VIM_RESOURCE_DIR}/plugged"
export VIMRUNTIME="${VIM_RESOURCE_DIR}/runtime"
export MYVIMRC=${MYVIMRC:-"${VIM_CONFIG_DIR}/init.vim"}
export VIMINIT='source $MYVIMRC'
