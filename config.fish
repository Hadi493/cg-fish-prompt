clear 
fastfetch

# Aliases
alias ll="ls -la"
alias la="ls -a"
alias cls="clear"
alias nv="nvim"
alias vi="nvim"
alias hx="helix"
alias toc="touch"
alias sys-upgrade="sudo pacman -Sy && sudo pacman -Syu -y"
alias sym-upgrade="sudo pacman -Syyu"
alias full-sys-upgrade="sudo pacman -Sy && sudo pacman -Syu -y && paru -Sy && paru -Syu -y && yay -Sy && yay -Syu -y"
alias zi="zed"
alias zi="zed"
alias zo="zed ."
alias tw="~/toggle-waybar.sh"
alias logout="hyprctl dispatch exit"
alias pacman="sudo pacman"



# OS name set globally
set -g os_name (string replace 'NAME=' '' (grep '^NAME=' /etc/os-release) | string trim --chars='"')

# fish prompt
function fish_prompt
    set -l last_status $status
    set_color 00ffaf
    echo -n "╭──("
    set_color 00ff87
    echo -n "$USER"
    set_color 00ffaf
    echo -n "(🌿)"
    set_color 00ff87
    echo -n "$os_name"
    set_color 00ffaf
    echo -n ")"

    if set -q VIRTUAL_ENV
        set_color ff5fff
        echo -n " ("(basename $VIRTUAL_ENV)")"
    end

    set_color 00ffaf
    echo -n " ["
    set_color 00ffaf
    echo -n (prompt_pwd)
    set_color 00ffaf
    echo -n "]"

    if git rev-parse --git-dir >/dev/null 2>&1
        set_color ff87d7
        echo -n " git:("(git rev-parse --abbrev-ref HEAD 2>/dev/null)")"
    end
    echo

    echo -n "╰─"
    if test $last_status -eq 0
        set_color 00ff87
        echo -n " ✔ "
    else
        set_color ff5f5f
        echo -n " ✘ "
    end
    set_color 00ffaf
    echo -n "❯ "
    set_color 00ffaf
end
