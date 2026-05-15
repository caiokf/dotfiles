#!/bin/bash
# Sets VS Code terminal tab description via ANSI escape sequence (OSC 2)
# Usage: terminal-status.sh <emoji>
# The emoji appears in the tab's ${sequence} description field
printf '\033]2;%s\a' "$1" > /dev/tty 2>/dev/null
exit 0
