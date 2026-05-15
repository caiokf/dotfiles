#!/bin/bash

script="$(dirname "$0")/log-prompt.py"

if [ ! -f "$script" ]; then
  exit 0
fi

exec python3 "$script"
