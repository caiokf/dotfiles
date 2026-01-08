#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Debug: uncomment to see actual JSON structure
echo "$input" > /tmp/statusline-debug.json

# Extract values from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
# Use current_usage for actual context window occupancy (null = 0)
current_input=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
cache_creation=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
context_total=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
context_used=$((current_input + cache_creation + cache_read))
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
session_id=$(echo "$input" | jq -r '.session_id // "unknown"')

# Track daily/monthly costs
usage_file="$HOME/.claude/usage-tracking.json"
today=$(date "+%Y-%m-%d")
month=$(date "+%Y-%m")

# Initialize or load usage file
if [ -f "$usage_file" ]; then
    usage=$(cat "$usage_file")
else
    usage='{}'
fi

# Reset daily if new day
stored_day=$(echo "$usage" | jq -r '.current_day // ""')
if [ "$stored_day" != "$today" ]; then
    usage=$(echo "$usage" | jq --arg d "$today" '.current_day = $d | .daily_cost = 0 | .sessions = {}')
fi

# Reset monthly if new month
stored_month=$(echo "$usage" | jq -r '.current_month // ""')
if [ "$stored_month" != "$month" ]; then
    usage=$(echo "$usage" | jq --arg m "$month" '.current_month = $m | .monthly_cost = 0')
fi

# Update session cost (replace, not add - sessions track cumulative cost)
# Handle both old format (number) and new format (object with cost/baselines)
session_data=$(echo "$usage" | jq -r --arg sid "$session_id" '.sessions[$sid] // empty')
if [ -n "$session_data" ]; then
    # Check if it's old format (number) or new format (object)
    is_object=$(echo "$usage" | jq --arg sid "$session_id" '.sessions[$sid] | type == "object"')
    if [ "$is_object" = "true" ]; then
        prev_session_cost=$(echo "$usage" | jq -r --arg sid "$session_id" '.sessions[$sid].cost // empty')
        session_cost_baseline=$(echo "$usage" | jq -r --arg sid "$session_id" '.sessions[$sid].cost_baseline // 0')
        session_token_baseline=$(echo "$usage" | jq -r --arg sid "$session_id" '.sessions[$sid].token_baseline // 0')
    else
        # Old format - treat as cost with zero baselines
        prev_session_cost="$session_data"
        session_cost_baseline=0
        session_token_baseline=0
    fi
else
    prev_session_cost=""
    session_cost_baseline=0
    session_token_baseline=0
fi

if [ -z "$prev_session_cost" ]; then
    # New session - check if cost matches existing session (/clear detection)
    # Use fuzzy matching (within 1 cent) to handle floating point differences
    # Also find the matching session's baseline to carry it forward
    matched_session=$(echo "$usage" | jq --argjson c "$cost" '
        .sessions | to_entries | map(select(
            ((.value | type) == "number" and ((.value - $c) | fabs) < 0.01) or
            ((.value | type) == "object" and ((.value.cost - $c) | fabs) < 0.01)
        )) | first // null
    ')

    if [ "$matched_session" != "null" ] && [ "$cost" != "0" ]; then
        # /clear detected - this session inherited cost from another, don't double count
        cost_delta=0
        # Set baselines to current values so display starts at $0/0 tokens after /clear
        session_cost_baseline="$cost"
        session_token_baseline="$context_used"
    else
        # Genuinely new session
        cost_delta="$cost"
        session_cost_baseline=0
        session_token_baseline=0
    fi
else
    # Existing session - normal delta calculation
    cost_delta=$(echo "$cost - $prev_session_cost" | bc)
fi

usage=$(echo "$usage" | jq --arg sid "$session_id" --argjson c "$cost" --argjson delta "$cost_delta" \
    --argjson cost_base "$session_cost_baseline" --argjson token_base "$session_token_baseline" '
    .sessions[$sid] = {cost: $c, cost_baseline: $cost_base, token_baseline: $token_base} |
    .daily_cost = ((.daily_cost // 0) + $delta) |
    .monthly_cost = ((.monthly_cost // 0) + $delta)
')

# Save and extract totals
echo "$usage" > "$usage_file"
daily_cost=$(echo "$usage" | jq -r '.daily_cost // 0')
monthly_cost=$(echo "$usage" | jq -r '.monthly_cost // 0')

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

# Apply baselines for display (shows current usage after /clear, not cumulative)
display_cost=$(echo "$cost - $session_cost_baseline" | bc)
display_context_used=$((context_used - session_token_baseline))
if [ "$display_context_used" -lt 0 ]; then display_context_used=0; fi

# Context progress bar
percent=$((display_context_used * 100 / context_total))
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
context_used_k=$((display_context_used / 1000))
context_total_k=$((context_total / 1000))
cost_formatted=$(printf '%.2f' "$display_cost")
daily_formatted=$(printf '%.2f' "$daily_cost")
monthly_formatted=$(printf '%.2f' "$monthly_cost")
bar+="]\033[0m ${percent}% | ${context_used_k}k/${context_total_k}k \033[32m#\033[0m \$${cost_formatted} | \$${daily_formatted}/day | \$${monthly_formatted}/mo"

# Code changes (green for added, red for removed)
code_changes=$(printf '\033[32m+%s\033[0m \033[31m-%s\033[0m' "$lines_added" "$lines_removed")

# Commits today
commits_today=0
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    commits_today=$(git -C "$cwd" --no-optional-locks log --oneline --since="midnight" 2>/dev/null | wc -l | tr -d ' ')
fi

# Output: time | model | dir | git | changes | commits | context
printf '\033[37m%s\033[0m | \033[32m%s\033[0m | %s%s | %s | commits: %s | %b' "$time_str" "$model" "$dir_name" "$git_info" "$code_changes" "$commits_today" "$bar"