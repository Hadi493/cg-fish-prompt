source /usr/share/cachyos-fish-config/cachyos-config.fish
set -gx PATH /home/cyber/Downloads/flutter_linux_3.27.1-stable/flutter/flutter/bin $PATH
set -g fish_greeting "Welcome to Fish Shell!"
set -Ux fish_user_paths /home/username/.gem/ruby/3.x.x/bin $fish_user_paths
alias ll="ls -la"

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end



# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
eval (ssh-agent -c)
set -Ux SSH_AUTH_SOCK (ls /tmp/ssh-*/agent.* 2>/dev/null)

function fish_prompt
    set_color cyan
    echo -n "┌──("
    set_color green
    echo -n cyber-green
    set_color red
    echo -n "🔐"
    set_color green
    echo -n (hostname)
    set_color cyan
    echo -n ")-["
    set_color yellow
    echo -n (prompt_pwd)
    set_color cyan
    echo -n "]"
    echo
    echo -n "└─\$ "
    set_color normal
end
