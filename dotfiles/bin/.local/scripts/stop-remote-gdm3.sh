#!/bin/bash
set -e

sudo systemctl stop gdm3 || true

pkill -9 Xorg || true
pkill -9 Xwayland || true
pkill -9 gnome-session || true

echo 'GUIs stopped'


if [[ $1 != "" ]]; then
  echo "Arg(s) detected, keeping config in place"
else
  mgmt_file='/etc/gdm3/bash-managed.txt'

  if [[ ! -f "$mgmt_file" ]]; then
    echo 'Management file not found! NOOP!'
    exit 0
  fi

  sudo rm "$mgmt_file"

  bak_file="/etc/gdm3/custom.conf.bak"
  cmd="mv"

  if [[ ! -f "$bak_file" ]]; then
    bak_file="/etc/gdm3/custom.conf.OG.bak"
    cmd="cp"
  fi
  sudo $cmd "$bak_file" /etc/gdm3/custom.conf
  echo 'cleaned configs'
fi

echo 'Remote GUI stop finish.'
