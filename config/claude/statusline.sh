#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Debug: uncomment to see actual JSON structure
echo "$input" > /tmp/statusline-debug.json

# Extract values from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
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
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# Time (HH:MM:SS)
time_str=$(date "+%H:%M:%S")

# Shortened directory
dir_name=$(basename "$cwd")

# Git status
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null || echo "detached")
    if git -C "$cwd" --no-optional-locks diff-index --quiet HEAD -- 2>/dev/null; then
        git_info=$(printf ' | \033[32m\033[0m %s' "$branch")
    else
        git_info=$(printf ' | \033[33m\033[0m %s' "$branch")
    fi
fi

# Context progress bar - use total_input_tokens directly (no baseline needed)
percent=$((context_used * 100 / context_total))
bar_width=45
filled=$((percent * bar_width / 100))
empty=$((bar_width - filled))

# Color based on usage: green < 50%, yellow 50-80%, red > 80%
if [ "$percent" -lt 50 ]; then
    bar_color="\033[32m"
elif [ "$percent" -lt 80 ]; then
    bar_color="\033[33m"
else
    bar_color="\033[31m"
fi

bar="${bar_color}["
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done
# Format tokens as "Xk/Yk"
context_used_k=$((context_used / 1000))
context_total_k=$((context_total / 1000))
bar+="]\033[0m ${percent}% | ${context_used_k}k/${context_total_k}k"

# Code changes (green for added, red for removed)
code_changes=$(printf '\033[32m+%s\033[0m \033[31m-%s\033[0m' "$lines_added" "$lines_removed")

# Commits today
commits_today=0
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    commits_today=$(git -C "$cwd" --no-optional-locks log --oneline --since="midnight" 2>/dev/null | wc -l | tr -d ' ')
fi

# Output: time | model | dir | git | changes | commits | context
printf '\033[37m%s\033[0m | \033[32m%s\033[0m | %s%s | %s | commits: %s | %b' "$time_str" "$model" "$dir_name" "$git_info" "$code_changes" "$commits_today" "$bar"
