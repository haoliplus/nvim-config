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
  [ -d "${HOME}/.asdf" ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
  echo 'source ${HOME}/.dotfiles/config/zshrc.sh' >> ${HOME}/.zshrc
  echo 'source ${HOME}/.asdf/asdf.sh' >> ${HOME}/.zshrc
  echo 'source ${HOME}/.asdf/completions/asdf.bash' >> ${HOME}/.zshrc
  echo 'source -q ${HOME}/.dotfiles/config/tmux.conf' >> ${HOME}/.tmux.conf

