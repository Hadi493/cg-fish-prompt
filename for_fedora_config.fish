    printf (set_color -o 00ffaf)"    %-12s" CPU
    printf (set_color 00d7ff)" ❯ %s\n" (set_color white)$cpu_info
    printf (set_color -o 00ffaf)"    %-12s" GPU
    printf (set_color 00d7ff)" ❯ %s\n" (set_color white)$gpu_info
    printf (set_color -o 00ffaf)"    %-12s" MEMORY
    printf (set_color 00d7ff)" ❯ %s\n" (set_color white)"$mem_used / $mem_total"
    printf (set_color -o 00ffaf)"    %-12s" NETWORK
    printf (set_color 00d7ff)" ❯ %s\n" (set_color white)(ip -br addr show wlan0 2>/dev/null | awk '{print $3}' | cut -d'/' -f1; or echo "Not connected")
    printf (set_color -o 00ffaf)"    %-12s" SHELL
    printf (set_color ff5fff)" ❯ %s\n" (set_color white)$shell_info
    printf (set_color -o 00ffaf)"    %-12s" DE/WM
    printf (set_color ff5fff)" ❯ %s\n" (set_color white)$de_info
    printf (set_color -o 00ffaf)"    %-12s" PACKAGES
    printf (set_color ff5fff)" ❯ %s\n" (set_color white)"$pkg_count installed"

    echo (set_color -o 00ff87)"
    [" (set_color -o ff5fff)"SYSTEM READY" (set_color -o 00ff87)"]  " (set_color white)$current_time
    echo
end

set ruby_gem_path "$HOME/.gem/ruby/3.x.x/bin"
if test -d "$ruby_gem_path"
    set -Ux fish_user_paths $ruby_gem_path $fish_user_paths
end

# Aliases
alias ll="ls -la"
alias la="ls -a"
alias cls="clear"
alias nv="nvim"
alias vi="nv"
alias zed="flatpak run dev.zed.Zed"
alias zd="zed ."
alias cava="./cava"
# # Start SSH agent if not already running
# if not pgrep -u $USER ssh-agent >/dev/null
#     eval (ssh-agent -c)
# end
#
function fish_prompt
    set -l last_status $status
    set_color 00ffaf
    echo -n "╭──("
    set_color 00ff87
    echo -n CYBER
    set_color 00ffaf
    echo -n "(🌿)"
    set_color 00ff87
    echo -n GREEN
    set_color 00ffaf
    echo -n ")"

    if set -q VIRTUAL_ENV
        set_color ff5fff
        echo -n " («"(basename $VIRTUAL_ENV)"»)"
    end

    set_color 00ffaf
    echo -n " ["
    set_color white
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

function __on_exit --on-event fish_exit
    if test -n "$SSH_AGENT_PID"
        ssh-agent -k >/dev/null 2>&1
    end
end

function mark --description "Bookmark directories for quick navigation"
    set -l bookmark_dir "$HOME/.config/fish/bookmarks"

    if not test -d $bookmark_dir
        mkdir -p $bookmark_dir
    end

    if test (count $argv) -eq 0
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

    set -l command $argv[1]

    switch $command
        case save add
            if test (count $argv) -lt 2
                echo (set_color red)"Usage: mark save|add <bookmark_name>"(set_color normal)
                return 1
            end

            set -l bookmark_name $argv[2]
            set -l current_dir (pwd)

            # Save bookmark
            echo $current_dir >"$bookmark_dir/$bookmark_name"
            echo (set_color green)"✓ Bookmark '$bookmark_name' saved: "(set_color yellow)"$current_dir"(set_color normal)

        case delete remove rm
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

        case help
            echo (set_color cyan)"Directory Bookmarking System"(set_color normal)
            echo (set_color green)"Usage:"(set_color normal)
            echo "  mark                     List all bookmarks"
            echo "  mark <name>              Jump to the specified bookmark"
            echo "  mark save <name>         Bookmark the current directory"
            echo "  mark delete <name>       Delete a bookmark"
            echo "  mark help                Show this help information"

        case "*"
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
                    if test "$confirm" = y -o "$confirm" = Y
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

function hf --description "Search command history with grep"
    if test (count $argv) -eq 0
        echo (set_color red)"Usage: hf <search term>"(set_color normal)
        return 1
    end

    set -l search_term $argv[1]
    set -l color_on (set_color yellow)
    set -l color_off (set_color normal)

    history | grep -n --color=always "$search_term"
    echo (set_color cyan)"To run a command by number, use: !<number>"(set_color normal)
end

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

    set -l success 0

    echo (set_color green)"→ Extracting: "(set_color yellow)$archive_file(set_color normal)

    switch $archive_file
        case "*.zip"
            if command -v unzip >/dev/null
                unzip $archive_file
                set success 1
            else
                echo (set_color red)"Error: 'unzip' is not installed"(set_color normal)
            end

        case "*.rar"
            if command -v unrar >/dev/null
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
            if command -v 7z >/dev_null
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

    if test $success -eq 1
        echo (set_color green)"✓ Extraction complete: $archive_file"(set_color normal)
    else
        echo (set_color red)"✗ Extraction failed: $archive_file"(set_color normal)
        return 1
    end
end

abbr -a m mark
abbr -a md "mark delete"
abbr -a ms "mark save"
abbr -a e extract
