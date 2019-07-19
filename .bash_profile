if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi

if which goenv > /dev/null; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export PATH="$GOPATH/bin:$PATH"
fi
