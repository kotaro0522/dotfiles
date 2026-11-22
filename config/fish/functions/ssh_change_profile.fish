function ssh_change_profile --description "change terminal background color when executing ssh"
    switch "$argv"
        case "*prod*"
            echo -ne "\033]1337;SetProfile=prod\a"
		case "*dev*"
			echo -ne "\033]1337;SetProfile=dev\a"
    end

    command ssh $argv

    echo -ne "\033]1337;SetProfile=Hotkey\a"
end
