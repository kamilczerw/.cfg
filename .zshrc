export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="kamil"

plugins=(
  git
  docker
  helm
  kubectl
  fzf-zsh-plugin
  zsh-autosuggestions
)

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

source $ZSH/oh-my-zsh.sh
alias config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

source ${HOME}/.git-conf/bash-aliases

# Local PATH
export PATH="${HOME}/.local/bin:${PATH}"

# Java env
export PATH="$HOME/.jenv/bin:/usr/local/sbin:$PATH"

# Terraform env
export PATH="$HOME/.tfenv/bin:$PATH"

# Yarn PATH
export PATH="${HOME}/.yarn/bin:$PATH"

eval "$(jenv init -)"

# Secrets
if [ ! -f ${HOME}/.secrets ]; then
  touch ${HOME}/.secrets
fi
source ${HOME}/.secrets

# export GIT_SSH_COMMAND="ssh -q"

# # 1password
# export OP_EMAIL="wojciech.kamil@gmail.com"
# if [ -z "$OP_SECRET_KEY" ]; then
#   echo "OP_SECRET_KEY is not set!\nAdd it to ${HOME}/.secrets"
#   echo "echo \"export OP_SECRET_KEY=A3-XXXXXX-XXXXXX-XXXXX-XXXXX-XXXXX-XXXXX\" >> ${HOME}/.secrets"
# fi

# Docker
alias doc=docker-compose
alias poc=podman-compose

# Go
export GOPATH=${HOME}/go
export PATH="${GOPATH}/bin:${PATH}"

#### Kubernetes ####
alias k="kubectl"
alias kn="kubectl ns"
alias kx="kubectl ctx"
alias stern="kubectl stern"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Add kubernetes prompt
# source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"

# Add kubernetes local 
export KUBECONFIG=~/.kube/config:~/.kube/homeserver


# Ruby path
export PATH="/usr/local/opt/ruby/bin:${HOME}/.gem/ruby/2.6.0/bin:$PATH"

# Cargo path
export PATH="${HOME}/bin:$HOME/.cargo/bin:${PATH}"

export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH


# Rust
source $HOME/.cargo/env

# Add jump
eval "$(jump shell)"

export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/gcloud/google-cloud-sdk/completion.zsh.inc'; fi

# fnm
#export PATH=/home/kamil/.fnm:$PATH
#eval "`fnm env`"

