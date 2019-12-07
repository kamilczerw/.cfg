export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="kamil"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
for f in ${HOME}/.functions/*; do source $f; done

alias config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

source ${HOME}/.git-conf/bash-aliases

# Java env
export PATH="$HOME/.jenv/shims:$PATH"

# Home bin
export PATH="${HOME}/bin:${PATH}"

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
