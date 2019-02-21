#!/usr/bin/env bash
set -e

# Install zsh and tmux
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt update
    sudo apt install -y zsh tmux
elif [[ "$OSTYPE" == "darwin"* ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install zsh tmux
fi

# Install tmux-resurect
mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.tmux/plugins/tmux-resurrect
git clone https://github.com/tmux-plugins/tmux-continuum $HOME/.tmux/plugins/tmux-continuum

# Install oh my zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
sudo sed -i s#${HOME}:/bin/bash#${HOME}:/bin/zsh#g /etc/passwd

# Checkout configuration
REPO="https://github.com/kamilczerw/.cfg"

git clone --bare $REPO $HOME/.cfg
config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

$config checkout
$config config --local status.showUntrackedFiles no