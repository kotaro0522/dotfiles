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
