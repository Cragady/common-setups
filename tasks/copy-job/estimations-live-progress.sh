#!/bin/bash
set -euo pipefail

# NOTE: Magic num as var better for now
ID="1780547937-505240"

DONE="/tmp/fpsync/done/$ID"

PARTS="/tmp/fpsync/parts/$ID"
# PARTS2=$(du -sb /tmp/fpsync/parts/"$ID"/*)
# NOTE: weighting partitions by size for more accuracy. If not wanted comment out.
# PARTS="$PARTS2"

total=$(ls "$PARTS" | wc -l)
done=$(find "$DONE" -type f 2>/dev/null | wc -l)

now=$(date +%s)

# store first run time
STATE_FILE="/tmp/fpsync-$ID.start"

if [[ ! -f "$STATE_FILE" ]]; then
  echo "$now" > "$STATE_FILE"
fi

start=$(cat "$STATE_FILE")
elapsed=$(( now - start ))

echo "Current Duration: $(date -d "@$elapsed" -u +%H:%M:%S) (h:m:s)"

if (( done > 0 )); then
  rate=$(awk -v d="$done" -v e="$elapsed" 'BEGIN { print d/e }')
  remaining=$(echo "$total - $done" | bc)

  eta=$(awk -v r="$remaining" -v rate="$rate" \
    'BEGIN { if(rate>0) print r/rate; else print 0 }')

  percent=$(awk -v d="$done" -v t="$total" \
    'BEGIN { printf "%.2f", (d/t)*100 }')

  echo "Progress: $done / $total ($percent%)"
  echo "ETA: $(date -d "@$eta" -u +%H:%M:%S) (h:m:s)"
else
  echo "Waiting for first completed partition..."
fi


###########################################################################


# DONE_DIR="/tmp/fpsync/done/1780547937-505240"
#
# completed=$(find "$DONE_DIR" -type f | wc -l)
#
# # adjust if needed (you can confirm max with: ls | sort -n | tail)
# total=260
#
# percent=$(awk -v c="$completed" -v t="$total" \
#   'BEGIN { printf "%.2f", (c/t)*100 }')
#
# echo "Completed: $completed / $total"
# echo "Progress: $percent%"

###########################################################################

# total=$(ls /tmp/fpsync/parts/1780547937-505240 | wc -l)
# completed=$(find /tmp/fpsync/done/1780547937-505240 -type f | wc -l)
#
# echo "$completed / $total"
