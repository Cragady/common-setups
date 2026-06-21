#!/bin/bash

# find /tmp/fpsync -name "*.done" | wc -l
# ls /tmp/fpsync/parts/*/
find /tmp/fpsync -maxdepth 3 -type f | head -50
