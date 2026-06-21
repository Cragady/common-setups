#!/bin/bash
set -euo pipefail

SOURCE="/mnt/8tbsrc"
DEST="/mnt/20tbdest"

total_bytes=$(du -sb "$SOURCE" | awk '{print $1}')
copied_bytes=$(du -sb "$DEST" | awk '{print $1}')

percent=$(awk -v c="$copied_bytes" -v t="$total_bytes" \
  'BEGIN { printf "%.2f", (c/t)*100 }')

echo "Progress: $percent%"
