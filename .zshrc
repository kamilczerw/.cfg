export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
for f in ~/.functions/*; do source $f; done

alias config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

source ~/.git-conf/bash-aliases

export PATH="${HOME}/bin:${PATH}"

# Secrets
if [ ! -f ~/.secrets ]; then
  touch ~/.secrets
fi
source ~/.secrets

export GIT_SSH_COMMAND="ssh -q"

# 1password
export OP_EMAIL="wojciech.kamil@gmail.com"
if [ -z "$OP_SECRET_KEY" ]; then
  echo "OP_SECRET_KEY is not set!\nAdd it to ~/.secrets"
  echo "echo \"export OP_SECRET_KEY=A3-XXXXXX-XXXXXX-XXXXX-XXXXX-XXXXX-XXXXX\" >> ~/.secrets"
fi

# Docker
alias doc=docker-compose

# Go
export GOPATH=${HOME}/go
export PATH="${GOPATH}/bin:${PATH}"

###### DICE ######
export PATH="${HOME}/work/dice/cmd/bin:${PATH}"

#### DICE END ####

# Run tmux
tmux
