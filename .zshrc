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

# Add kubernetes local 
export KUBECONFIG=~/.kube/config

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
alias docker-login="$(aws-okta exec staging-admin -- aws ecr get-login --no-include-email --region eu-west-1)"
# Ruby path
export PATH="/usr/local/opt/ruby/bin:${HOME}/.gem/ruby/2.6.0/bin:$PATH"

export PATH="${HOME}/bin:$HOME/.cargo/bin:${PATH}"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/kczerwinski/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/kczerwinski/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/kczerwinski/opt/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/kczerwinski/opt/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/opt/gcloud/path.zsh.inc' ]; then . '/usr/local/opt/gcloud/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/opt/gcloud/completion.zsh.inc' ]; then . '/usr/local/opt/gcloud/completion.zsh.inc'; fi

export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

