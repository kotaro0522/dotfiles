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
  eval "$(goenv init -)"
fi
