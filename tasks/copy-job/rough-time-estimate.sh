#!/usr/bin/env bash
set -euo pipefail

SOURCE="/mnt/8tbsrc"
DEST="/mnt/20tbdest"

total=$(du -sb "$SOURCE" | awk '{print $1}')
current=$(du -sb "$DEST" | awk '{print $1}')

elapsed=$(
  systemctl show \
    -p ActiveEnterTimestampMonotonic \
    copy-games.service \
    | cut -d= -f2
)

elapsed_sec=$(( elapsed / 1000000 ))

if (( current > 0 && elapsed_sec > 0 )); then
  rate=$(( current / elapsed_sec ))

  remaining=$(( total - current ))

  eta=$(( remaining / rate ))

  printf "Progress: %.2f%%\n" \
    "$(awk -v c="$current" -v t="$total" \
      'BEGIN { print (c/t)*100 }')"

  printf "Speed: %.2f MiB/s\n" \
    "$(awk -v r="$rate" 'BEGIN { print r/1024/1024 }')"

  printf "ETA: %02dd %02dh %02dm\n" \
    $(( eta/86400 )) \
    $(( (eta%86400)/3600 )) \
    $(( (eta%3600)/60 ))
fi
