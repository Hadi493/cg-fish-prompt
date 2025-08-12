clear
fastfetch

# ===============================================
# FISH SHELL ENHANCED CONFIGURATION
# ===============================================

# Enable all Fish features
set -g fish_greeting ''

# ===============================================
# FISH AUTOCOMPLETION & SYNTAX HIGHLIGHTING
# ===============================================

# Enable syntax highlighting (enabled by default but ensuring it's on)
set -g fish_color_normal normal
set -g fish_color_command 005fd7
set -g fish_color_quote 999900
set -g fish_color_redirection 00afff
set -g fish_color_end 009900
set -g fish_color_error ff0000
set -g fish_color_param 00afff
set -g fish_color_comment 990000
set -g fish_color_match --background=brblue
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_history_current --bold
set -g fish_color_operator 00a6b2
set -g fish_color_escape 00a6b2
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_valid_path --underline
set -g fish_color_autosuggestion 555 brblack
set -g fish_color_user brgreen
set -g fish_color_host normal
set -g fish_color_cancel -r

# Pager colors
set -g fish_pager_color_completion normal
set -g fish_pager_color_description B3A06D yellow
set -g fish_pager_color_prefix white --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan

# ===============================================
# AUTOCOMPLETION SETTINGS
# ===============================================

# Enable case-insensitive autocompletion
set -g fish_complete_case_insensitive 1

# Enable autosuggestions from history
set -g fish_autosuggestion_enabled 1

# ===============================================
# HISTORY SETTINGS
# ===============================================

# Set history size
set -g fish_history_max 10000

# Save timestamp in history
set -g fish_save_timestamp 1

# ===============================================
# KEY BINDINGS FOR BETTER UX
# ===============================================

# Vi mode (optional - uncomment if you prefer vi keybindings)
# fish_vi_key_bindings

# Default emacs mode keybindings (recommended for most users)
fish_default_key_bindings

# Enhanced navigation
bind \e\[1\;5C forward-word  # Ctrl+Right
bind \e\[1\;5D backward-word # Ctrl+Left
bind \cH backward-kill-word  # Ctrl+Backspace
bind \e\[3\;5~ kill-word     # Ctrl+Delete

# History search with arrow keys
bind \e\[A history-search-backward  # Up arrow
bind \e\[B history-search-forward   # Down arrow

# ===============================================
# FUNCTIONS FOR ENHANCED EXPERIENCE
# ===============================================

# Enhanced ls with colors
function ls --wraps=ls --description="Enhanced ls with colors"
    command ls --color=auto $argv
end

# Better grep with colors
function grep --wraps=grep --description="Enhanced grep with colors"
    command grep --color=auto $argv
end

# Enhanced tree command if available
if command -q tree
    function tree --wraps=tree --description="Enhanced tree with colors"
        command tree -C $argv
    end
end

# Smart cd that lists contents
function cd --wraps=cd --description="cd with auto-ls"
    builtin cd $argv
    and ls
end

# Extract function for various archive formats
function extract --description="Extract various archive formats"
    if test (count $argv) -ne 1
        echo "Usage: extract <archive>"
        return 1
    end
    
    set -l file $argv[1]
    
    if not test -f $file
        echo "Error: '$file' is not a valid file"
        return 1
    end
    
    switch $file
        case '*.tar.bz2'
            tar xjf $file
        case '*.tar.gz'
            tar xzf $file
        case '*.bz2'
            bunzip2 $file
        case '*.rar'
            unrar x $file
        case '*.gz'
            gunzip $file
        case '*.tar'
            tar xf $file
        case '*.tbz2'
            tar xjf $file
        case '*.tgz'
            tar xzf $file
        case '*.zip'
            unzip $file
        case '*.Z'
            uncompress $file
        case '*.7z'
            7z x $file
        case '*'
            echo "Error: '$file' cannot be extracted via extract()"
            return 1
    end
end

# Quick file finder
function ff --description="Find files quickly"
    find . -name "*$argv*" 2>/dev/null
end

# Process finder
function psg --description="Grep running processes"
    ps aux | grep -v grep | grep -i $argv
end

# Weather function (requires curl)
function weather --description="Get weather info"
    if test (count $argv) -eq 0
        curl -s "wttr.in?format=3"
    else
        curl -s "wttr.in/$argv[1]?format=3"
    end
end

# Theme Environment Variables
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x QT_STYLE_OVERRIDE Adwaita-Dark
set -x GTK_THEME Adwaita:dark

# Add ~/.local/bin to PATH
set -gx PATH $HOME/.local/bin $PATH

# ===============================================
# ENHANCED ALIASES
# ===============================================

# Basic file operations
alias ll="ls -la"
alias la="ls -a"
alias l="ls -CF"
alias cls="clear"
alias c="clear"
alias cleanup="pacman -Sc && pacman -Scc"
alias toc="touch"
alias md="mkdir -pv"  # Create parent directories and be verbose
alias cp="cp -i"         # Interactive copy
alias mv="mv -i"         # Interactive move
alias rm="rm -i"         # Interactive remove
alias logout="hyprctl dispatch exit"


# yt-dlp
alias dv="yt-dlp --no-playlist"

# Editor aliases
alias nv="nvim"
alias hx="helix"
alias et="emacs -nw"

# Git aliases
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gs="git status"
alias gd="git diff"
alias gco="git checkout"
alias gacp='git add . && git commit -m "..." && git push'
alias done="gacp"

alias git_graph="git log --graph --oneline --decorate --all"
alias g_graph="git log --graph --pretty=format:'%C(auto)%h%d %s %C(blue)</%an>' --all"
alias gb_graph="git log --graph --abbrev-commit --decorate --all --format=format:'%C(bold blue)%h%C(reset) - %C(dim white)%an%C(reset) %C(bold yellow)%d%C(reset)%n''%C(white)%s%C(reset)' --date=short"

# System monitoring
alias htop="htop -C"     # Colorized htop
alias df="df -h"         # Human readable disk usage
alias du="du -h"         # Human readable directory usage
alias free="free -h"     # Human readable memory usage
alias ps="ps auxf"       # Full process list

# Network
alias ping="ping -c 5"   # Ping 5 times by default
alias wget="wget -c"     # Continue partial downloads

# Safety aliases
alias chown="chown --preserve-root"
alias chmod="chmod --preserve-root"
alias chgrp="chgrp --preserve-root"

# Custom Aliases
alias sys-upgrade="sudo pacman -Sy && sudo pacman -Syu -y"
alias sym-upgrade="sudo pacman -Syyu"
alias full-sys-upgrade="sudo pacman -Sy && sudo pacman -Syu -y && paru -Sy && paru -Syu -y && yay -Sy && yay -Syu -y"
alias pacman="sudo pacman"
alias set-wallpaper="feh --bg-fill"

set -g os_name (string replace 'NAME=' '' (grep '^NAME=' /etc/os-release) | string trim --chars='"')

# ===============================================
# ENHANCED PROMPTS
# ===============================================

# fish prompt (left prompt)
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

    # Virtual env 
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

    # git branch with status
    if git rev-parse --git-dir >/dev/null 2>&1
        set -l git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
        set -l git_status (git status --porcelain 2>/dev/null)
        set_color ff87d7
        echo -n " git:($git_branch"
        
        # Show git status indicators
        if test -n "$git_status"
            set_color yellow
            echo -n "*"
        end
        set_color ff87d7
        echo -n ")"
    end
    
    # Show exit status if non-zero
    if test $last_status -ne 0
        set_color red
        echo -n " [$last_status]"
    end
    
    echo
    echo -n "╰─"
    set_color 00ffaf
    echo -n " ❯❯ "
    set_color normal
end

# Right prompt with time and additional info
function fish_right_prompt
    set -l cmd_duration $CMD_DURATION
    set -l timestamp (date "+%H:%M:%S")
    
    # Show command duration if > 2 seconds
    if test $cmd_duration -gt 2000
        set -l duration_seconds (math "$cmd_duration / 1000")
        set_color yellow
        echo -n "⏱ {$duration_seconds}s "
    end
    
    # Show current time
    set_color 666666
    echo -n "$timestamp"
    set_color normal
end

# Title function to set terminal title
function fish_title
    echo (status current-command) " " (prompt_pwd)
end
set -gx PATH ~/.config/emacs/bin $PATH

# Key bindings
# Ctrl+E to launch Emacs
bind \ce 'emacs &; commandline -f repaint'

# Additional convenience bindings
# Ctrl+Alt+E to launch Emacs in terminal mode
bind \e\ce 'emacs -nw; commandline -f repaint'

# Function to launch Emacs with file if specified
function launch_emacs
    set -l current_line (commandline)
    if test -n "$current_line"
        # If there's text on command line, treat it as filename
        emacs $current_line &
        commandline ''
    else
        # Otherwise just launch Emacs
        emacs &
    end
    commandline -f repaint
end

# Bind Ctrl+Shift+E to launch Emacs with current command line as filename
bind \e\[69\;6u 'launch_emacs'
set -gx PATH /home/cg/.deno/bin $PATH
