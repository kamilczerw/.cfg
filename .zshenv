. "$HOME/.cargo/env"

# Local PATH
export PATH="${HOME}/.local/bin:${PATH}"

# Brew PATH
export PATH="${PATH}:/opt/homebrew/bin"
# Linuxbrew PATH
export PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

# Java env
# export PATH="$HOME/.jenv/bin:/usr/local/sbin:$PATH"

# Terraform env
export PATH="$HOME/.tfenv/bin:$PATH"

# Yarn PATH
export PATH="${HOME}/.yarn/bin:$PATH"


# Go
export GOPATH=${HOME}/go
export PATH="${GOPATH}/bin:${PATH}"

export ZK_NOTEBOOK_DIR="${HOME}/Notes/zk"
