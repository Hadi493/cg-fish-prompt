# Check if running as root
if test (id -u) -eq 0
    set config_file "$HOME/.config/fish/config.fish"
    if test -f "$config_file"
        source "$config_file"
    end
end


# Add Flutter to PATH if directory exists

set flutter_path "$HOME/Downloads/flutter_linux_3.27.1-stable/flutter/flutter/bin"
if test -d "$flutter_path"
    if not contains $flutter_path $PATH
        set -gx PATH $flutter_path $PATH
    end
end


# Custom greeting with ASCII art
function fish_greeting
    clear
    
    # Enhanced system information gathering
    set -l current_time (date "+%H:%M:%S" 2>/dev/null; or echo "Unknown")
    set -l current_date (date "+%Y-%m-%d" 2>/dev/null; or echo "Unknown")
    set -l username (whoami 2>/dev/null; or echo "User")
    set -l cpu_info (grep "model name" /proc/cpuinfo | head -n1 | sed 's/^.*: //')
    set -l mem_total (free -h | awk '/^Mem:/ {print $2}')
    set -l mem_used (free -h | awk '/^Mem:/ {print $3}')
    set -l disk_info (df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')
    set -l shell_info (fish --version)
    set -l gpu_info (lspci | grep -i 'vga\|3d' | cut -d ':' -f3 | string trim)
    set -l pkg_count (rpm -qa | wc -l)
    set -l de_info $XDG_CURRENT_DESKTOP
    set -l kernel_ver (uname -r)
    set -l uptime_info (uptime -p | sed 's/up //')
    set -l network_info (ip -br addr show | awk '$1!="lo" {print $1 ": " $3}')

    set -l os_name (grep "^NAME=" /etc/os-release | sed 's/NAME=//' | tr -d '"')

    # Enhanced CYBER GREEN ASCII art
    set_color 00ff87
    echo "
    ╔══════════════════════════════════════════════════════════════════════════════════╗
    ║                                                                                  ║
    ║   ██████╗██╗   ██╗██████╗ ███████╗██████╗                                        ║
    ║  ██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗      ▄██████▄  █▄████▄ ▄███████       ║
    ║  ██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝      ██░░░░░██ ██░░░██ ██░░░░░█       ║
    ║  ██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗      ██░░███░█ ██░░░██ ██░░███        ║
    ║  ╚██████╗   ██║   ██████╔╝███████╗██║  ██║      ░██████░  ░████░█ ░██████        ║
    ║   ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝      ░░░░░░    ░░░░░░  ░░░░░░         ║
    ║                                                                                  ║
    ║   ██████╗ ██████╗ ███████╗███████╗███╗   ██╗                                     ║
    ║  ██╔════╝ ██╔══██╗██╔════╝██╔════╝████╗  ██║     •:•:•:• SYSTEM •:•:•:•          ║
    ║  ██║  ███╗██████╔╝█████╗  █████╗  ██╔██╗ ██║     •:•:• INFORMATION •:•:•         ║
    ║  ██║   ██║██╔══██╗██╔══╝  ██╔══╝  ██║╚██╗██║                                     ║
    ║  ╚██████╔╝██║  ██║███████╗███████╗██║ ╚████║        [ $os_name ]                 ║
    ║   ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝                                     ║
    ╚══════════════════════════════════════════════════════════════════════════════════╝"

    # Modern system info display
    # Create a fancy separator line
    set_color -o 00ffaf
    echo "    ╔════════════════════════════ SYSTEM INFORMATION ═════════════════════════════╗"
    printf (set_color -o 00ffaf)"    %-12s" "SYSTEM"
    printf (set_color ff87d7)" ❯ %s\n" (set_color white)"Fedora Linux"
    printf (set_color -o 00ffaf)"    %-12s" "KERNEL"
    printf (set_color ff87d7)" ❯ %s\n" (set_color white)$kernel_ver
    printf (set_color -o 00ffaf)"    %-12s" "USER"
    printf (set_color ff87d7)" ❯ %s\n" (set_color white)"$username@"(hostname)
    printf (set_color -o 00ffaf)"    %-12s" "CPU"
    printf (set_color 00d7ff)" ❯ %s\n" (set_color white)$cpu_info
    printf (set_color -o 00ffaf)"    %-12s" "GPU"
    printf (set_color 00d7ff)" ❯ %s\n" (set_color white)$gpu_info
    printf (set_color -o 00ffaf)"    %-12s" "MEMORY"
    printf (set_color 00d7ff)" ❯ %s\n" (set_color white)"$mem_used / $mem_total"
    printf (set_color -o 00ffaf)"    %-12s" "NETWORK"
    printf (set_color 00d7ff)" ❯ %s\n" (set_color white)(ip -br addr show wlan0 2>/dev/null | awk '{print $3}' | cut -d'/' -f1; or echo "Not connected")
    printf (set_color -o 00ffaf)"    %-12s" "SHELL"
    printf (set_color ff5fff)" ❯ %s\n" (set_color white)$shell_info
    printf (set_color -o 00ffaf)"    %-12s" "DE/WM"
    printf (set_color ff5fff)" ❯ %s\n" (set_color white)$de_info
    printf (set_color -o 00ffaf)"    %-12s" "PACKAGES"
    printf (set_color ff5fff)" ❯ %s\n" (set_color white)"$pkg_count installed"
    # echo (set_color -o 00ffaf)"
    # ┗━══════════════════════════════════════════════════════════════════════════════════════┛"

    # Minimal status bar
    echo (set_color -o 00ff87)"
    [" (set_color -o ff5fff)"SYSTEM READY" (set_color -o 00ff87)"]  " (set_color white)$current_time
    echo
end

# Add Ruby gems to user paths if directory exists
set ruby_gem_path "$HOME/.gem/ruby/3.x.x/bin"
if test -d "$ruby_gem_path"
    set -Ux fish_user_paths $ruby_gem_path $fish_user_paths
end

# Aliases
alias ll="ls -la"
alias la="ls -a"
alias cls="clear"
alias nv="nvim"
alias vi="nvim"
alias toc="touch"
alias sys-upgrade="sudo dnf upgrade"
alias zi="zed"
alias zo="zed ."
alias logout="hyprctl dispatch exit"
# Start SSH agent if not already running
if not pgrep -u $USER ssh-agent >/dev/null
    eval (ssh-agent -c)
end
# Custom prompt function
function fish_prompt

    set -l os_name (grep "^NAME=" /etc/os-release | sed 's/NAME=//' | tr -d '"')

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
        echo -n " («"(basename $VIRTUAL_ENV)"»)"
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
    set_color normal
end

# Cleanup function for when shell exits
function __on_exit --on-event fish_exit
    if test -n "$SSH_AGENT_PID"
        ssh-agent -k >/dev/null 2>&1
    end
end

# Directory Bookmarking System
# ----------------------------
function mark --description "Bookmark directories for quick navigation"
    set -l bookmark_dir "$HOME/.config/fish/bookmarks"
    
    # Create bookmark directory if it doesn't exist
    if not test -d $bookmark_dir
        mkdir -p $bookmark_dir
    end
    
    # Check for arguments
    if test (count $argv) -eq 0
        # List all existing bookmarks if no arguments provided
        echo (set_color cyan)"Available bookmarks:"(set_color normal)
        
        set -l mark_files (ls -A $bookmark_dir 2>/dev/null)
        if test (count $mark_files) -eq 0
            echo (set_color yellow)"  No bookmarks exist yet"(set_color normal)
            echo (set_color green)"  Use 'mark name' to bookmark the current directory"(set_color normal)
        else
            for bookmark in $mark_files
                set -l bookmark_path (cat "$bookmark_dir/$bookmark")
                printf (set_color green)"  %s" $bookmark
                printf (set_color normal)" -> "
                printf (set_color yellow)"%s\n" $bookmark_path
            end
        end
        return 0
    end
    
    # Handle bookmark operations
    set -l command $argv[1]
    
    switch $command
        case "save" "add"
            # Save current directory with specified name
            if test (count $argv) -lt 2
                echo (set_color red)"Usage: mark save|add <bookmark_name>"(set_color normal)
                return 1
            end
            
            set -l bookmark_name $argv[2]
            set -l current_dir (pwd)
            
            # Save bookmark
            echo $current_dir > "$bookmark_dir/$bookmark_name"
            echo (set_color green)"✓ Bookmark '$bookmark_name' saved: "(set_color yellow)"$current_dir"(set_color normal)
            
        case "delete" "remove" "rm"
            # Remove a bookmark
            if test (count $argv) -lt 2
                echo (set_color red)"Usage: mark delete|remove|rm <bookmark_name>"(set_color normal)
                return 1
            end
            
            set -l bookmark_name $argv[2]
            
            if test -f "$bookmark_dir/$bookmark_name"
                rm "$bookmark_dir/$bookmark_name"
                echo (set_color green)"✓ Bookmark '$bookmark_name' deleted"(set_color normal)
            else
                echo (set_color red)"✗ Bookmark '$bookmark_name' does not exist"(set_color normal)
                return 1
            end
            
        case "help"
            # Show help information
            echo (set_color cyan)"Directory Bookmarking System"(set_color normal)
            echo (set_color green)"Usage:"(set_color normal)
            echo "  mark                     List all bookmarks"
            echo "  mark <name>              Jump to the specified bookmark"
            echo "  mark save <name>         Bookmark the current directory"
            echo "  mark delete <name>       Delete a bookmark"
            echo "  mark help                Show this help information"
            
        case "*"
            # Try to navigate to the specified bookmark
            set -l bookmark_name $command
            set -l bookmark_file "$bookmark_dir/$bookmark_name"
            
            if test -f $bookmark_file
                set -l bookmark_path (cat $bookmark_file)
                if test -d $bookmark_path
                    cd $bookmark_path
                    echo (set_color green)"→ Jumped to "(set_color yellow)"$bookmark_path"(set_color normal)
                else
                    echo (set_color red)"✗ Bookmark path no longer exists: $bookmark_path"(set_color normal)
                    echo (set_color yellow)"Delete this bookmark? [y/N]"(set_color normal)
                    read -l confirm
                    if test "$confirm" = "y" -o "$confirm" = "Y"
                        rm $bookmark_file
                        echo (set_color green)"✓ Bookmark '$bookmark_name' deleted"(set_color normal)
                    end
                    return 1
                end
            else
                echo (set_color red)"✗ Bookmark '$bookmark_name' does not exist"(set_color normal)
                echo (set_color yellow)"Available bookmarks:"(set_color normal)
                
                set -l mark_files (ls -A $bookmark_dir 2>/dev/null)
                if test (count $mark_files) -eq 0
                    echo (set_color yellow)"  No bookmarks exist yet"(set_color normal)
                else
                    for bookmark in $mark_files
                        echo (set_color green)"  $bookmark"(set_color normal)
                    end
                end
                return 1
            end
    end
end

# Enhanced Command History Search
# ------------------------------
function hf --description "Search command history with grep"
    if test (count $argv) -eq 0
        echo (set_color red)"Usage: hf <search term>"(set_color normal)
        return 1
    end
    
    set -l search_term $argv[1]
    set -l color_on (set_color yellow)
    set -l color_off (set_color normal)
    
    # Use history command to get history, then grep for the search term with line numbers
    # Using history command to get history, then grep for the search term with line numbers
    # Use grep's built-in color functionality to highlight the matches
    history | grep -n --color=always "$search_term"
    echo (set_color cyan)"To run a command by number, use: !<number>"(set_color normal)
end

# Universal Extraction Function
# ----------------------------
function extract --description "Extract common archive formats"
    if test (count $argv) -eq 0
        echo (set_color red)"Usage: extract <archive file>"(set_color normal)
        echo (set_color cyan)"Supported formats: zip, rar, tar, tar.gz, tar.bz2, tar.xz, 7z, gz, bz2, xz"(set_color normal)
        return 1
    end
    
    set -l archive_file $argv[1]
    
    if not test -f $archive_file
        echo (set_color red)"Error: File '$archive_file' does not exist"(set_color normal)
        return 1
    end
    
    # Create variable to track success
    set -l success 0
    
    echo (set_color green)"→ Extracting: "(set_color yellow)$archive_file(set_color normal)
    
    # Extract based on file extension
    switch $archive_file
        case "*.zip"
            if command -v unzip > /dev/null
                unzip $archive_file
                set success 1
            else
                echo (set_color red)"Error: 'unzip' is not installed"(set_color normal)
            end
            
        case "*.rar"
            if command -v unrar > /dev/null
                unrar x $archive_file
                set success 1
            else
                echo (set_color red)"Error: 'unrar' is not installed"(set_color normal)
            end
            
        case "*.tar"
            tar -xf $archive_file
            set success 1
            
        case "*.tar.gz" "*.tgz"
            tar -xzf $archive_file
            set success 1
            
        case "*.tar.bz2" "*.tbz2"
            tar -xjf $archive_file
            set success 1
            
        case "*.tar.xz" "*.txz"
            tar -xJf $archive_file
            set success 1
            
        case "*.7z"
            if command -v 7z > /dev_null
                7z x $archive_file
                set success 1
            else
                echo (set_color red)"Error: '7z' is not installed"(set_color normal)
            end
            
        case "*.gz"
            gunzip $archive_file
            set success 1
            
        case "*.bz2"
            bunzip2 $archive_file
            set success 1
            
        case "*.xz"
            unxz $archive_file
            set success 1
            
        case "*"
            echo (set_color red)"Error: Unsupported file format"(set_color normal)
            echo (set_color cyan)"Supported formats: zip, rar, tar, tar.gz, tar.bz2, tar.xz, 7z, gz, bz2, xz"(set_color normal)
            return 1
    end
    
    # Report success
    if test $success -eq 1
        echo (set_color green)"✓ Extraction complete: $archive_file"(set_color normal)
    else
        echo (set_color red)"✗ Extraction failed: $archive_file"(set_color normal)
        return 1
    end
end

# Abbreviations for the new functions
abbr -a m "mark"
abbr -a md "mark delete"
abbr -a ms "mark save"
abbr -a e "extract"
