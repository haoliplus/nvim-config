default:
  just --list

link:
  echo "Add nvim"

[linux]
prepare_deps:
  #!/usr/bin/env sh
  echo "Unix"
  # if alpine, elif debian/ubuntu
  if $(grep -q "alpine" /etc/os-release); then
    echo "Alpine"
    # apk update
    # apk upgrade
    # apk add git zsh curl
  elif $(grep -q "debian" /etc/os-release); then
    echo "Debian|Ubuntu"
    # apt update
    # apt upgrade -y
    # apt install -y git zsh curl
  fi

[macos]
prepare_deps:
  echo "MacOS"
  # brew update
  # brew upgrade
  # brew install git zsh curl

install:
  echo 'source ${HOME}/.config/dotfiles/config/zshrc.sh' >> ${HOME}/.zshrc

