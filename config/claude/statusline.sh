#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Debug: uncomment to see actual JSON structure
echo "$input" > /tmp/statusline-debug.json

# Extract values from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir // .workspace.current_dir')
# Use current_usage sum for actual context window occupancy (total_input_tokens is cumulative across all calls)
current_input=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
cache_creation=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
context_total=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
# Ensure numeric values
[[ "$current_input" =~ ^[0-9]+$ ]] || current_input=0
[[ "$cache_creation" =~ ^[0-9]+$ ]] || cache_creation=0
[[ "$cache_read" =~ ^[0-9]+$ ]] || cache_read=0
[[ "$context_total" =~ ^[0-9]+$ ]] || context_total=200000
context_used=$((current_input + cache_creation + cache_read))
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"' | tr '[:upper:] ' '[:lower:]-')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# Time (HH:MM:SS)
time_str=$(date "+%H:%M:%S")

# Shortened directory - resolve actual repo root (not worktree path)
repo_root=$(git -C "$cwd" rev-parse --path-format=absolute --git-common-dir 2>/dev/null | sed 's|/\.git$||')
dir_name=$(basename "${repo_root:-$project_dir}")

# Git status
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null || echo "detached")
    if git -C "$cwd" --no-optional-locks diff-index --quiet HEAD -- 2>/dev/null; then
        git_info=$(printf ' |\033[32m\033[0m %s' "$branch")
    else
        git_info=$(printf ' |\033[33m\033[0m %s' "$branch")
    fi
fi

# Context progress bar - use total_input_tokens directly (no baseline needed)
percent=$((context_used * 100 / context_total))
bar_width=19
filled=$((percent * bar_width / 100))
empty=$((bar_width - filled))

# Color based on usage: green < 50%, yellow 50-80%, red > 80%
if [ "$percent" -lt 50 ]; then
    filled_bg="\033[48;5;22m"
    empty_bg="\033[48;5;236m"
elif [ "$percent" -lt 80 ]; then
    filled_bg="\033[48;5;136m"
    empty_bg="\033[48;5;236m"
else
    filled_bg="\033[48;5;88m"
    empty_bg="\033[48;5;236m"
fi

context_used_k=$((context_used / 1000))
context_total_k=$((context_total / 1000))
left=" ${context_used_k}k/${context_total_k}k"
right="${percent}% "
# Left-align used/total, right-align percent, fill middle with spaces
mid_pad=$((bar_width - ${#left} - ${#right}))
padded=$(printf "%s%${mid_pad}s%s" "$left" "" "$right")

# Render bar with background colors, text overlaid
filled_text="${padded:0:$filled}"
empty_text="${padded:$filled}"
bar="${filled_bg}\033[97m[${filled_text}${empty_bg}${empty_text}]\033[0m"

# Code changes (green for added, red for removed, blue for commits)
commits_today=0
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    commits_today=$(git -C "$cwd" --no-optional-locks log --oneline --since="midnight" 2>/dev/null | wc -l | tr -d ' ')
fi
stats=$(printf '\033[32m+%s\033[0m \033[31m-%s\033[0m \033[34m+%s\033[0m' "$lines_added" "$lines_removed" "$commits_today")

# Output: model context | dir | stats | git
printf '\033[32m%s\033[0m %b \033[33m%s\033[0m | %s%s' "$model" "$bar" "$dir_name" "$stats" "$git_info"
