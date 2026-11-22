# omf の default テーマ（https://github.com/oh-my-fish/theme-default）を移植したもの
function fish_right_prompt
    set_color $fish_color_autosuggestion 2> /dev/null; or set_color 555
    date "+%H:%M:%S"
    set_color normal
end
