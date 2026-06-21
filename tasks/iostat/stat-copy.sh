#!/bin/bash

rm output.log || true

iostat -p sda,sdb -xz 5 | tee -a output.log &

while true; do
  sleep 30
  clear
done

# NOTE: to follow
# less +F output.log


# NOTE: Healthy:
# %util: 90-100%
# await: 10-40 ms

# NOTE: Too much parallelism:
# %util: 100%
# await: hundreds of ms
# or multiple seconds

# NOTE: When fpsync reaches the phase with the largest files,
# you may see:
# r/s      decrease
# rareq-sz increase
# await    decrease
# throughput increase
