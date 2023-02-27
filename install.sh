#!/usr/bin/env bash
set -e

TEMP_DIR=$(mktemp -d)
trap "rm -rf ${TEMP_DIR}" EXIT

# Install zsh and tmux
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt update
    
    sudo apt install -y zsh jq fzf 

    sudo snap install yq jump

    sudo snap install kubectl --classic
    sudo snap install go --classic

elif [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="$PATH:/opt/homebrew/bin"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install zsh gpg jenv go kubectl yq jq fzf jump
fi


# Install zgenom
if [ ! -d $HOME/.zgenom ]; then git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom" ; fi

if [ $SHELL != "/bin/zsh" ]; then chsh -s /bin/zsh ; fi

# Checkout configuration
if [ ! -d $HOME/.cfg ]; then
  echo "Setting up .cfg repo"
  REPO="https://github.com/kamilczerw/.cfg"

  if [ ! -d $HOME/.cfg ]; then git clone --bare $REPO $HOME/.cfg ; fi
  config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

  $config checkout
  $config config --local status.showUntrackedFiles no
  $config config user.name "Kamil Czerwiński"
  $config config user.email "kamil@czerwinski.dev"

  git config --global include.path "${HOME}/.git-conf/config"
else
  echo ".cfg has already been initialized. Skipping"
fi

# Install krew for kubectl
if [ ! -d $HOME/.krew ]; then
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW=./krew-"${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    "$KREW" install krew
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
    krew install ctx
    krew install ns
  )
fi

# Install MacOS specific apps
# if [[ "$OSTYPE" == "darwin"* ]]; then
  # brew cask install sequel-pro visual-studio-code clipy
# fi

# Install tfenv
if [ ! -d $HOME/.tfenv ]; then 
  git clone https://github.com/tfutils/tfenv.git $HOME/.tfenv
else
  echo "tfenv has already been installed. Skipping"
fi

SSH_CONF_DIR=$HOME/.ssh/config.d/

if [ ! -f $SSH_CONF_DIR/local ]; then
  [ -d $SSH_CONF_DIR ] || mkdir $SSH_CONF_DIR/

  echo "Host github.com
  User git
  IdentityFile ~/.ssh/keys/github.key" > $SSH_CONF_DIR/local

  echo "!!! Remember to create ~/.ssh/keys/github.key"
fi
