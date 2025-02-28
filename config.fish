# Check if running as root (id -u = 0)
if test (id -u) -eq 0
    set config_file "$HOME/.config/fish/config.fish"
    if test -f "$config_file"
        source "$config_file"
    end
end

# Source CachyOS config if it exists
set cachyos_config "/usr/share/cachyos-fish-config/cachyos-config.fish"
if test -f "$cachyos_config"
    source "$cachyos_config"
end

# Add Flutter to PATH if directory exists
set flutter_path "$HOME/Downloads/flutter_linux_3.27.1-stable/flutter/flutter/bin"
if test -d "$flutter_path"
    set -gx PATH $flutter_path $PATH
end

# Set greeting
set -g fish_greeting "Welcome to Fish Shell!"

# Add Ruby gems to user paths if directory exists
set ruby_gem_path "$HOME/.gem/ruby/3.x.x/bin"
if test -d "$ruby_gem_path"
    set -Ux fish_user_paths $ruby_gem_path $fish_user_paths
end

# Aliases
alias ll="ls -la"
alias la="ls -a"
alias cls="clear"

# Start SSH agent if not already running
if not pgrep -u $USER ssh-agent >/dev/null
    eval (ssh-agent -c)
end

# Custom prompt function
function fish_prompt
    set -l last_status $status # Store last command's status

    # First line
    set_color cyan
    echo -n "┌──("
    set_color green
    echo -n cyber-green
    set_color green
    echo -n "(🔐)"
    set_color #c3e88d
    echo -n (hostname)
    set_color cyan
    echo -n ")-"

    # Virtual environment indicator
    if set -q VIRTUAL_ENV
        set_color cyan
        echo -n "("
        set_color magenta
        echo -n (basename $VIRTUAL_ENV)
        set_color cyan
        echo -n ")-"
    end

    # Current directory
    set_color cyan
    echo -n "["
    set_color yellow
    echo -n (prompt_pwd)
    set_color cyan
    echo -n "]"

    # Show git branch if in git repository
    if git rev-parse --git-dir >/dev/null 2>&1
        set_color cyan
        echo -n " git:("
        set_color red
        echo -n (git rev-parse --abbrev-ref HEAD 2>/dev/null)
        set_color cyan
        echo -n ")"
    end

    echo
    # Second line with status indicator
    set_color cyan
    echo -n "└─"
    if test $last_status -eq 0
        set_color green
        echo -n "✔ "
    else
        set_color red
        echo -n "✘ "
    end
    set_color cyan
    echo -n "\$ "
    set_color normal
end

# Cleanup function for when shell exits
function __on_exit --on-event fish_exit
    if test -n "$SSH_AGENT_PID"
        ssh-agent -k >/dev/null 2>&1
    end
end
