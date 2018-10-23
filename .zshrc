export ZSH="/home/kamil/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
for f in ~/.functions/*; do source $f; done

alias config='/usr/bin/git --git-dir=/home/kamil/.cfg/ --work-tree=/home/kamil'
