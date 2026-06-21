#!/bin/bash
set -Eeuo pipefail

SOURCE="/mnt/8tbsrc"
DEST="/mnt/20tbdest"

exec fpsync \
  -n 4 \
  "$SOURCE" \
  "$DEST"

##### DIRECTIONS (for service portion)

#### Link to services and reload daemons
### sudo ln -sf \
###   /home/cragady/common-setups/tasks/copy-job/copy-games.service \
###   /etc/systemd/system/copy-games.service

### sudo systemctl daemon-reload


#### Start Service
### sudo systemctl start copy-games.service



#### Stop Service
### sudo systemctl stop copy-games.service


#### LOGS
### sudo journalctl -copy-games.service
### sudo systemctl status copy-games.service


#### Remove Completely
### sudo systemctl stop copy-games.service
### sudo systemctl disable copy-games.service
### sudo rm /etc/systemd/system/copy-games.service
### sudo systmctl daemon-reload


