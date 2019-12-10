export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="kamil"

plugins=(
  git
  docker
  helm
  kubectl
)

source $ZSH/oh-my-zsh.sh
alias config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

source ${HOME}/.git-conf/bash-aliases

# Java env
export PATH="$HOME/.jenv/shims:$PATH"

# Secrets
if [ ! -f ${HOME}/.secrets ]; then
  touch ${HOME}/.secrets
fi
source ${HOME}/.secrets

export GIT_SSH_COMMAND="ssh -q"

# 1password
export OP_EMAIL="wojciech.kamil@gmail.com"
if [ -z "$OP_SECRET_KEY" ]; then
  echo "OP_SECRET_KEY is not set!\nAdd it to ${HOME}/.secrets"
  echo "echo \"export OP_SECRET_KEY=A3-XXXXXX-XXXXXX-XXXXX-XXXXX-XXXXX-XXXXX\" >> ${HOME}/.secrets"
fi

# Docker
alias doc=docker-compose

# Go
export GOPATH=${HOME}/go
export PATH="${GOPATH}/bin:${PATH}"

# Run tmux
tmux

#### Kubernetes ####
alias k="kubectl"
alias kn="kubens"
alias kx="kubectx"

# Add kubernetes prompt
# source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"

#### Profile ####
if [ ! -f ${HOME}/.defaults ]; then
  touch ${HOME}/.defaults
fi

source ${HOME}/.defaults

set_profile_name() {
  read profile
  echo "export PROFILE=$profile" >> ${HOME}/.defaults
  source ${HOME}/.defaults
}

if [ -z "$PROFILE" ]; then
  echo "\nPROFILE is not set!\nAdd it to ${HOME}/.defaults"
  echo "Do you want to set it now? [Y/n]"
  read yn
    case $yn in
        [Yy]* ) set_profile_name ;;
    esac
else 
  source ${HOME}/Dropbox/work/${PROFILE}/.profile
fi


alias aws-session=". ${HOME}/bin/aws-session-script"

export PATH="${HOME}/bin:${PATH}"
