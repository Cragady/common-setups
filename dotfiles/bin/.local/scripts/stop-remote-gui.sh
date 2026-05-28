#!/bin/bash

set -e

pkill -9 -u "$USER" rustdesk || true
pkill -9 -u "$USER" xfce4-session || true
pkill -9 -u "$USER" Xorg || true
pkill -9 -u "$USER" startplasma-x11 || true
pkill -9 -u "$USER" plasmashell || true
pkill -9 -u "$USER" ksmserver || true
pkill -9 -u "$USER" kwin_x11 || true


echo 'GUIs stopped'


if [[ $1 != "" ]]; then
  echo "Arg(s) detected, keeping config in place"
else
  mgmt_file='/etc/X11/bash-managed.txt'

  if [[ ! -f "$mgmt_file" ]]; then
    echo 'Management file not found! NOOP!'
    exit 0
  fi

  sudo rm "$mgmt_file"

  bak_file="/etc/X11/Xwrapper.config.bak"
  cmd="mv"

  if [[ ! -f "$bak_file" ]]; then
    bak_file="/etc/X11/Xwrapper.config.OG.bak"
    cmd="cp"
  fi
  sudo $cmd "$bak_file" /etc/X11/Xwrapper.config
  echo 'cleaned configs'
fi

echo 'Remote GUI stop finish.'
