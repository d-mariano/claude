#!/bin/bash

# Enhanced Claude Code Statusline
# Displays: time, user, directory, git status, context usage, and cost

# Read JSON input from stdin
input=$(cat)

# Extract basic fields
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
TRANSCRIPT_PATH=$(echo "$input" | jq -r '.transcript_path // empty')
TOTAL_COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

# Format time and user
TIME_STR=$(date '+%H:%M:%S')
USER_STR=$(whoami)
DIR_STR=$(basename "$CURRENT_DIR")

# Get git status
GIT_INFO=""
if git -C "$CURRENT_DIR" rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git -C "$CURRENT_DIR" branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        # Check if repo is dirty
        if ! git -C "$CURRENT_DIR" diff --quiet 2>/dev/null || \
           ! git -C "$CURRENT_DIR" diff --cached --quiet 2>/dev/null; then
            GIT_INFO=$(printf " on \033[33m%s*\033[0m" "$BRANCH")
        else
            GIT_INFO=$(printf " on \033[32m%s\033[0m" "$BRANCH")
        fi
    fi
fi

# Calculate current context window from transcript if available
CONTEXT_INFO=""
if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ]; then
    # Find the most recent non-sidechain entry and get its context window size
    # This matches how Claude Code calculates current context
    CURRENT_CONTEXT=$(cat "$TRANSCRIPT_PATH" | \
        jq -s 'map(select((.isSidechain // false) == false and (.isApiErrorMessage // false) == false and .message.usage != null)) |
               sort_by(.timestamp) |
               last |
               .message.usage |
               ((.input_tokens // 0) + (.cache_read_input_tokens // 0) + (.cache_creation_input_tokens // 0))' 2>/dev/null)

    # Calculate percentage of 200K context window
    CONTEXT_LIMIT=200000
    if [ -n "$CURRENT_CONTEXT" ] && [ "$CURRENT_CONTEXT" != "null" ] && [ "$CURRENT_CONTEXT" -gt 0 ] 2>/dev/null; then
        CONTEXT_PCT=$(echo "scale=0; $CURRENT_CONTEXT * 100 / $CONTEXT_LIMIT" | bc 2>/dev/null)

        # Color code based on usage
        if [ -n "$CONTEXT_PCT" ] && (( $(echo "$CONTEXT_PCT >= 80" | bc -l 2>/dev/null) )); then
            CONTEXT_COLOR="\033[31m"  # Red
        elif [ -n "$CONTEXT_PCT" ] && (( $(echo "$CONTEXT_PCT >= 50" | bc -l 2>/dev/null) )); then
            CONTEXT_COLOR="\033[33m"  # Yellow
        elif [ -n "$CONTEXT_PCT" ] && (( $(echo "$CONTEXT_PCT >= 16" | bc -l 2>/dev/null) )); then
            CONTEXT_COLOR="\033[93m"  # Yellow-green (bright yellow)
        else
            CONTEXT_COLOR="\033[32m"  # Green
        fi

        # Format tokens with K suffix for readability
        if [ "$CURRENT_CONTEXT" -ge 1000 ]; then
            TOKEN_DISPLAY=$(echo "scale=1; $CURRENT_CONTEXT / 1000" | bc 2>/dev/null)
            CONTEXT_LIMIT_DISPLAY=$(echo "scale=0; $CONTEXT_LIMIT / 1000" | bc 2>/dev/null)
            CONTEXT_INFO=$(printf " | %b%sK/%sK (%s%%)\\033[0m" "$CONTEXT_COLOR" "$TOKEN_DISPLAY" "$CONTEXT_LIMIT_DISPLAY" "$CONTEXT_PCT")
        else
            CONTEXT_INFO=$(printf " | %b%s/%s (%s%%)\\033[0m" "$CONTEXT_COLOR" "$CURRENT_CONTEXT" "$CONTEXT_LIMIT" "$CONTEXT_PCT")
        fi
    fi
fi

# Format cost if available
COST_INFO=""
if [ "$(echo "$TOTAL_COST > 0" | bc)" -eq 1 ]; then
    COST_INFO=$(printf " | \$%.4f" "$TOTAL_COST")
fi

# Output formatted statusline
printf "\033[2m%s %s\033[0m in \033[36m%s\033[0m%s | \033[35m%s\033[0m%s%s" \
    "$TIME_STR" \
    "$USER_STR" \
    "$DIR_STR" \
    "$GIT_INFO" \
    "$MODEL_DISPLAY" \
    "$CONTEXT_INFO" \
    "$COST_INFO"
