#!/bin/bash

make --always-make --dry-run \
 | grep -wE 'gcc|g\+\+' \
 | grep -w '\-c' \
 | jq -nR '[inputs|{directory:".", command:., file: match(" [^ ]+$").string[1:]}]' \
 > compile_commands.json

echo "If the above command did not work, then use 'make -n <wanted_args>' to see if you can get what you want."
