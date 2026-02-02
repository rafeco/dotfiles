#!/bin/bash

# Read JSON input
input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Substitute home directory with ~
user=$(whoami)
display_cwd=$(echo "$cwd" | sed "s|^/Users/$user|~|; s|^/home/$user|~|")

# Base prompt: username@hostname:directory
printf '\033[36m%s@%s\033[0m:\033[35m%s\033[0m' "$(whoami)" "$(hostname -s)" "$display_cwd"

# Git enhancements
if cd "$cwd" 2>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null; then
    # Get current branch
    branch=$(git --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)

    # Check for dirty/clean status
    dirty=""
    if ! git --no-optional-locks diff --quiet 2>/dev/null || \
       ! git --no-optional-locks diff --cached --quiet 2>/dev/null || \
       [ -n "$(git --no-optional-locks ls-files --others --exclude-standard 2>/dev/null)" ]; then
        dirty="*"
    fi

    # Get ahead/behind counts relative to remote
    ahead_behind=""
    upstream=$(git --no-optional-locks rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
    if [ -n "$upstream" ]; then
        counts=$(git --no-optional-locks rev-list --left-right --count HEAD...$upstream 2>/dev/null)
        if [ -n "$counts" ]; then
            ahead=$(echo "$counts" | awk '{print $1}')
            behind=$(echo "$counts" | awk '{print $2}')
            [ "$ahead" -gt 0 ] && ahead_behind="${ahead_behind}↑${ahead}"
            [ "$behind" -gt 0 ] && ahead_behind="${ahead_behind}↓${behind}"
            [ -n "$ahead_behind" ] && ahead_behind=" ${ahead_behind}"
        fi
    fi

    # Get stash count
    stash_info=""
    stash_count=$(git --no-optional-locks stash list 2>/dev/null | wc -l | tr -d ' ')
    if [ "$stash_count" -gt 0 ]; then
        stash_info=" stash:${stash_count}"
    fi

    # Print git info in yellow
    printf '\033[33m (%s%s%s%s)\033[0m' "$branch" "$dirty" "$ahead_behind" "$stash_info"
fi

echo
