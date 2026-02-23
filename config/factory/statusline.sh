#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values from JSON
cwd=$(echo "$input" | jq -r '.cwd')
model_raw=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"')
transcript=$(echo "$input" | jq -r '.transcript_path // ""')

# Shorten model name
model=$(echo "$model_raw" | sed -E \
    -e 's/Claude Opus 4\.6.*/opus-4.6/' \
    -e 's/Claude Opus 4\.5.*/opus-4.5/' \
    -e 's/Claude Sonnet 4\.6.*/sonnet-4.6/' \
    -e 's/Claude Sonnet 4\.5.*/sonnet-4.5/' \
    -e 's/Claude Haiku 4\.5.*/haiku-4.5/' \
    -e 's/GPT-5\.3-Codex.*/codex-5.3/' \
    -e 's/GPT-5\.2-Codex.*/codex-5.2/' \
    -e 's/GPT-5\.1-Codex-Max.*/codex-5.1-max/' \
    -e 's/GPT-5\.1-Codex.*/codex-5.1/' \
    -e 's/GPT-5\.2.*/gpt-5.2/' \
    -e 's/GPT-5\.1.*/gpt-5.1/' \
    -e 's/Gemini 3 Pro.*/gemini-3-pro/' \
    -e 's/Kimi K2\.5.*/kimi-k2.5/' \
    -e 's/MiniMax M2\.5.*/minimax-m2.5/' \
    -e 's/Droid Core.*/droid-core/')

# Time (HH:MM:SS)
time_str=$(date "+%H:%M:%S")

# Shortened directory
dir_name=$(basename "$cwd")

# Git info
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null || echo "detached")
    if git -C "$cwd" --no-optional-locks diff-index --quiet HEAD -- 2>/dev/null; then
        git_info=$(printf ' | \033[32m\033[0m%s' "$branch")
    else
        git_info=$(printf ' | \033[33m\033[0m%s' "$branch")
    fi
fi

# Code changes from git (staged + unstaged)
lines_added=0
lines_removed=0
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    diff_stat=$(git -C "$cwd" --no-optional-locks diff --numstat HEAD 2>/dev/null)
    if [ -n "$diff_stat" ]; then
        lines_added=$(echo "$diff_stat" | awk '{s+=$1} END {print s+0}')
        lines_removed=$(echo "$diff_stat" | awk '{s+=$2} END {print s+0}')
    fi
fi
code_changes=$(printf '\033[32m+%s\033[0m \033[31m-%s\033[0m' "$lines_added" "$lines_removed")

# Commits today
commits_today=0
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    commits_today=$(git -C "$cwd" --no-optional-locks log --oneline --since="midnight" 2>/dev/null | wc -l | tr -d ' ')
fi

# Estimated context window usage from transcript file
# Approximation: count total chars in transcript, divide by ~4 for token estimate
context_total=200000
context_used=0
bar=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
    file_chars=$(wc -c < "$transcript" 2>/dev/null | tr -d ' ')
    # JSONL overhead is roughly 40% of file size, so content ~60%
    # ~4 chars per token on average
    context_used=$(( (file_chars * 60 / 100) / 4 ))
    # Cap at context_total
    [ "$context_used" -gt "$context_total" ] && context_used=$context_total
fi

percent=$((context_used * 100 / context_total))
bar_width=30
filled=$((percent * bar_width / 100))
empty=$((bar_width - filled))

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
context_used_k=$((context_used / 1000))
context_total_k=$((context_total / 1000))
bar+="]\033[0m ${percent}% (${context_used_k}k/${context_total_k}k)"

# Output: time | model | dir | context | git | changes | commits
printf '\033[37m%s\033[0m | \033[32m%s\033[0m | %s | %b%s | %s | commits: %s' "$time_str" "$model" "$dir_name" "$bar" "$git_info" "$code_changes" "$commits_today"
