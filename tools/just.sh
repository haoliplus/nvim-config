#!/bin/bash
set -ex

# if already installed just
just --version && echo "just is already installed" && exit 0

# create ~/bin
mkdir -p ~/bin

# download and extract just to ~/bin/just
JUST_VERSION=1.34.0
JUST_FNAME=just-${JUST_VERSION}-x86_64-unknown-linux-musl
wget -qO- https://github.com/casey/just/releases/download/${JUST_VERSION}/${JUST_FNAME}.tar.gz  \
  | tar xvz -C /tmp && sudo mv /tmp/just /usr/local/bin/just

# add `~/bin` to the paths that your shell searches for executables
# this line should be added to your shells initialization file,
# e.g. `~/.bashrc` or `~/.zshrc`
# export PATH="$PATH:$HOME/bin"

# just should now be executable
# just --help
which just
