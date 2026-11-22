# 新しいPCでツールが未インストールでもエラーにならないよう、各初期化は存在チェック付きにしている

if status is-interactive
    test -x /opt/homebrew/bin/brew; and /opt/homebrew/bin/brew shellenv | source
    type -q direnv; and direnv hook fish | source
    type -q rbenv; and rbenv init - fish | source
end

fish_add_path $HOME/.local/bin

set -x PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT
    set -x PATH $PYENV_ROOT/bin $PATH
    type -q pyenv; and pyenv init - | source
end

alias ssh="ssh_change_profile"
alias csv='ov --header 1 --column-delimiter "," --column-mode --column-rainbow'
alias tf="terraform"

set -x DISABLE_SPRING true

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/nishioka/miniconda3/bin/conda
    eval /Users/nishioka/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/nishioka/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/nishioka/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/nishioka/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

# asdf の設定は conf.d/asdf.fish
