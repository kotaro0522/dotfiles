function brew-maintain --description 'Homebrew の更新・アップグレード・掃除をして Brewfile を最新にする'
    # dotfiles の場所は ~/.config/fish のリンク先から割り出す
    set -l dotfiles (path resolve ~/.config/fish/../..)
    set -l brewfile $dotfiles/Brewfile

    echo (set_color cyan)"==> brew update"(set_color normal)
    brew update; or return 1

    set -l outdated (brew outdated)
    if test (count $outdated) -gt 0
        echo (set_color cyan)"==> アップグレード可能なパッケージ"(set_color normal)
        printf '  %s\n' $outdated
        read -l -P 'アップグレードしますか？ [y/N] ' answer
        if string match -qi y -- $answer
            brew upgrade; or return 1
        end
    else
        echo "すべて最新です"
    end

    echo (set_color cyan)"==> brew cleanup"(set_color normal)
    brew cleanup

    if test -f $brewfile
        echo (set_color cyan)"==> Brewfile を更新"(set_color normal)
        brew bundle dump --file=$brewfile --force --no-npm
        if git -C $dotfiles diff --quiet -- Brewfile
            echo "Brewfile に変更はありません"
        else
            git -C $dotfiles --no-pager diff -- Brewfile
            echo (set_color yellow)"Brewfile が変わりました。確認してコミットしてください: $dotfiles"(set_color normal)
        end
    else
        echo (set_color yellow)"Brewfile が見つかりません（$brewfile）。install.sh 実行後に使ってください"(set_color normal)
    end
end
