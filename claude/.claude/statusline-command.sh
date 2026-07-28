#!/bin/zsh
# Claude Code status line - shows usage info styled to match the shell prompt

input=$(cat)

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Git branch from the input's cwd
cwd=$(echo "$input" | jq -r '.cwd // empty')
git_branch=""
if [ -n "$cwd" ]; then
    git_branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null || true)
fi

# Context window usage (pre-calculated percentage)
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Rate limits
five_h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Build the status line
parts=()

if [ -n "$model" ]; then
    parts+=("$(printf '\033[0;36m%s\033[0m' "$model")")
fi

if [ -n "$git_branch" ]; then
    parts+=("$(printf '\033[0;35m%s\033[0m' "$git_branch")")
fi

if [ -n "$used_pct" ]; then
    used_int=$(printf '%.0f' "$used_pct")
    if [ "$used_int" -ge 80 ]; then
        color='\033[0;31m'  # red
    elif [ "$used_int" -ge 50 ]; then
        color='\033[0;33m'  # yellow
    else
        color='\033[0;32m'  # green
    fi
    parts+=("$(printf "ctx: ${color}%s%%\033[0m" "$used_int")")
fi

limits=""
if [ -n "$five_h" ]; then
    limits="5h:$(printf '%.0f' "$five_h")%"
fi
if [ -n "$seven_d" ]; then
    [ -n "$limits" ] && limits="$limits "
    limits="${limits}7d:$(printf '%.0f' "$seven_d")%"
fi
if [ -n "$limits" ]; then
    parts+=("$(printf '\033[38;5;208m%s\033[0m' "$limits")")
fi

# Join parts with " | " separator
result=""
for part in "${parts[@]}"; do
    if [ -n "$result" ]; then
        result="$result $(printf '\033[38;5;245m|\033[0m') $part"
    else
        result="$part"
    fi
done

printf "%s" "$result"
