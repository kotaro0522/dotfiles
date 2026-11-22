# omf の default テーマ（https://github.com/oh-my-fish/theme-default）を移植したもの。
# omf 本体が持っていた git ヘルパーは __prompt_git_* として同じファイル内に定義している。
#
# 設定ファイルで次のオプションを上書きできる:
#  set -g theme_short_path yes
#  set -g theme_stash_indicator yes
#  set -g theme_ignore_ssh_awareness yes

function __prompt_git_is_repo
    command git rev-parse --git-dir >/dev/null 2>&1
end

function __prompt_git_branch_name
    command git symbolic-ref --short HEAD 2>/dev/null
    or command git show-ref --head -s --abbrev 2>/dev/null | head -n1
end

function __prompt_git_is_stashed
    command git rev-parse --verify --quiet refs/stash >/dev/null 2>&1
end

function __prompt_git_is_touched
    set -l changes (command git status --porcelain 2>/dev/null)
    test -n "$changes"
end

function __prompt_git_ahead -a ahead behind diverged none
    set -l commit_count (command git rev-list --count --left-right "@{upstream}...HEAD" 2>/dev/null)
    switch "$commit_count"
        case ""
            # upstream なし
        case "0"\t"0"
            echo $none
        case "*"\t"0"
            echo $behind
        case "0"\t"*"
            echo $ahead
        case "*"
            echo $diverged
    end
end

function fish_prompt
    set -l last_command_status $status
    set -l cwd

    if test "$theme_short_path" = 'yes'
        set cwd (basename (prompt_pwd))
    else
        set cwd (prompt_pwd)
    end

    set -l fish     "⋊>"
    set -l ahead    "↑"
    set -l behind   "↓"
    set -l diverged "⥄"
    set -l dirty    "⨯"
    set -l stash    "≡"
    set -l none     "◦"

    set -l normal_color     (set_color normal)
    set -l success_color    (set_color cyan)
    set -l error_color      (set_color $fish_color_error 2> /dev/null; or set_color red --bold)
    set -l directory_color  (set_color $fish_color_quote 2> /dev/null; or set_color brown)
    set -l repository_color (set_color $fish_color_cwd 2> /dev/null; or set_color green)

    set -l prompt_string $fish

    if test "$theme_ignore_ssh_awareness" != 'yes' -a -n "$SSH_CLIENT$SSH_TTY"
        set prompt_string "$fish "(whoami)"@"(hostname -s)" $fish"
    end

    if test $last_command_status -eq 0
        echo -n -s $success_color $prompt_string $normal_color
    else
        echo -n -s $error_color $prompt_string $normal_color
    end

    if __prompt_git_is_repo
        if test "$theme_short_path" = 'yes'
            set -l root_folder (command git rev-parse --show-toplevel 2> /dev/null)
            set -l parent_root_folder (dirname $root_folder)
            set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
        end

        echo -n -s " " $directory_color $cwd $normal_color
        echo -n -s " on " $repository_color (__prompt_git_branch_name) $normal_color " "

        set -l list
        if test "$theme_stash_indicator" = yes; and __prompt_git_is_stashed
            set list $list $stash
        end
        if __prompt_git_is_touched
            set list $list $dirty
        end
        echo -n $list

        if test -z "$list"
            echo -n -s (__prompt_git_ahead $ahead $behind $diverged $none)
        end
    else
        echo -n -s " " $directory_color $cwd $normal_color
    end

    echo -n -s " "
end
