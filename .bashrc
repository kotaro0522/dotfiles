# for node.js
export PATH=$PATH:/Users/kotaro.nishioka/.nodebrew/current/bin

# aliases
alias ll='ls -lF'
alias la='ls -AF'
alias l='ls -1F'

alias grep='grep --color=auto'

alias py='python'

# set alias to copy the content of a file for Mac
if [ "$(uname)" == 'Darwin' ]; then
  function cop() {
    cat $1 | pbcopy
  }

  alias cop=cop
fi

source $HOME/.git-prompt.sh
source $HOME/.git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1

export PS1="\[\e[32m\]\h@\u \[\e[0m\]\W\[\e[36m\]\$(__git_ps1)\[\e[0m\]\n\$ "

