#!/bin/bash
# Can also `| cut -f1` instead too
SOURCE_BYTES=$(du -sb /mnt/8tbsrc | awk '{print $1}')
DEST_BYTES=$(du -sb /mnt/20tbdest | awk '{print $1}')

PERCENT=$(awk -v d="$DEST_BYTES" -v s="$SOURCE_BYTES" \
  'BEGIN { printf "%.2f", (d/s)*100 }')

echo "$PERCENT"

# watch -n 30 '
# src=$(du -sb /mnt/8tbsrc | cut -f1)
# dst=$(du -sb /mnt/20tbdest | cut -f1)
#
# awk -v s="$src" -v d="$dst" \
#   "BEGIN {
#     printf(\"Progress: %.2f%%\n\", (d/s)*100)
#   }"
# '
