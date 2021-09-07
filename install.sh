#!/usr/bin/env bash
set -e

TEMP_DIR=$(mktemp -d)
trap "rm -rf ${TEMP_DIR}" EXIT

# Install zsh and tmux
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # sudo apt update
    # sudo apt install -y zsh tmux
    sudo snap install go
elif [[ "$OSTYPE" == "darwin"* ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install zsh tmux gpg jenv go
fi


# # Install oh my zsh
if [ ! -d $HOME/.oh-my-zsh ]; then git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh ; fi
if [ $SHELL != "/bin/zsh" ]; then chsh -s /bin/zsh ; fi

# Checkout configuration
if [ ! -d $HOME/.cfg ]; then
  REPO="https://github.com/kamilczerw/.cfg"

  if [ ! -d $HOME/.cfg ]; then git clone --bare $REPO $HOME/.cfg ; fi
  config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

  $config checkout
  $config config --local status.showUntrackedFiles no
  $config config user.name "Kamil Czerwiński"
  $config config user.email "kam.czerwinski@gmail.com"

  git config --global include.path "${HOME}/.git-conf/config"
else
  echo ".cfg has already been initialized. Skipping"
fi

# Install MacOS specific apps
# if [[ "$OSTYPE" == "darwin"* ]]; then
  # brew cask install sequel-pro visual-studio-code clipy
# fi

# Install jump
go get github.com/gsamokovarov/jump

# Install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

