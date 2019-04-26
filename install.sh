#!/usr/bin/env bash
set -e

TEMP_DIR=$(mktemp -d)
trap "rm -rf ${TEMP_DIR}" EXIT

# Install zsh and tmux
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt update
    sudo apt install -y zsh tmux
elif [[ "$OSTYPE" == "darwin"* ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install zsh tmux gpg
fi

# Install 1password cli
OP_VERSION=${OP_VERSION:-"v0.5.5"}
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    OP_NAME="op_linux_amd64_${OP_VERSION}.zip"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OP_NAME="op_darwin_amd64_${OP_VERSION}.zip"
fi
pushd $TEMP_DIR
  curl -o $OP_NAME https://cache.agilebits.com/dist/1P/op/pkg/${OP_VERSION}/${OP_NAME}
  unzip $OP_NAME -d $TEMP_DIR
  gpg --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
  gpg --verify op.sig op

  mv op /usr/local/bin/op
popd

# Install tmux-resurect
mkdir -p $HOME/.tmux/plugins
if [ ! -d $HOME/.tmux/plugins/tmux-resurrect ]; then git clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.tmux/plugins/tmux-resurrect ; fi
if [ ! -d $HOME/.tmux/plugins/tmux-continuum ]; then git clone https://github.com/tmux-plugins/tmux-continuum $HOME/.tmux/plugins/tmux-continuum ; fi

# # Install oh my zsh
if [ ! -d $HOME/.oh-my-zsh ]; then git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh ; fi
# sudo sed -i s#${HOME}:/bin/bash#${HOME}:/bin/zsh#g /etc/passwd

# Checkout configuration
REPO="https://github.com/kamilczerw/.cfg"

if [ ! -d $HOME/.cfg ]; then git clone --bare $REPO $HOME/.cfg ; fi
config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

$config checkout
$config config --local status.showUntrackedFiles no

# Setup git
if ! git config user.email ; then
  echo "Please set git email: "
  read GIT_EMAIL

  git config --global user.email "${GIT_EMAIL}"
fi

git config --global include.path "${HOME}/.git-conf/config"