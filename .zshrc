export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="kamil"

zmodload zsh/zprof

# plugins=(
#   git
#   docker
#   helm
#   kubectl
#   fzf-zsh-plugin
#   zsh-autosuggestions
# )

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

source $ZSH/oh-my-zsh.sh
alias config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

source ${HOME}/.git-conf/bash-aliases

# eval "$(jenv init -)"

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

#### Kubernetes ####
alias k="kubectl"
alias kn="kubectl ns"
alias kx="kubectl ctx"
alias stern="kubectl stern"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Add kubernetes prompt
# source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"

# Add kubernetes local 
export KUBECONFIG=~/.kube/config:~/.kube/home-tmp:~/.kube/kamhome


# Ruby path
export PATH="/usr/local/opt/ruby/bin:${HOME}/.gem/ruby/2.6.0/bin:$PATH"

# Cargo path
export PATH="${HOME}/bin:$HOME/.cargo/bin:${PATH}"

export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH


# Rust
if [ -f '/opt/gcloud/google-cloud-sdk/path.zsh.inc' ]; then source $HOME/.cargo/env; fi

# Add jump
eval "$(jump shell)"

export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

# fnm
#export PATH=/home/kamil/.fnm:$PATH
#eval "`fnm env`"

# This is used to load nvm lazily by zsh-nvm plugin
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')

export NVM_DIR="$HOME/.nvm"

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

if ! zgenom saved; then
  echo "Creating a zgenom save"

  # Add this if you experience issues with missing completions or errors mentioning compdef.
  # zgenom compdef

  # Ohmyzsh base library
  zgenom ohmyzsh

  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/sudo
  # zgenom ohmyzsh plugins/zsh-nvm
  
  [[ "$(uname -s)" = Darwin ]] && zgenom ohmyzsh plugins/macos
  
#   zgenom ohmyzsh plugins/docker
#   zgenom ohmyzsh plugins/helm
#   zgenom ohmyzsh plugins/kubectl
  # zgenom load unixorn/fzf-zsh-plugin
#   zgenom ohmyzsh plugins/helm

  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom load zsh-users/zsh-autosuggestions
  
  zgenom load unixorn/fzf-zsh-plugin

  zgenom load lukechilds/zsh-nvm

  # save all to init script
  zgenom save

  # Compile your zsh files
  zgenom compile "$HOME/.zshrc"
  # zgenom compile $ZDOTDIR

  # You can perform other "time consuming" maintenance tasks here as well.
  # If you use `zgenom autoupdate` you're making sure it gets
  # executed every 7 days.

  # rbenv rehash
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/nomad nomad

complete -o nospace -C /Users/kamilczerwinski/go/bin/nomad-pack nomad-pack

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/kamil/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/kamil/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/kamil/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/kamil/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
