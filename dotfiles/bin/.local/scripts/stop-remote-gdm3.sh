#!/bin/bash
set -e

sudo systemctl stop gdm3 || true

sudo pkill -9 Xorg || true
sudo pkill -9 Xwayland || true
sudo pkill -9 gnome-session || true
sudo pkill -9 gnome-shell || true
sudo pkill -9 gdm3 || true

echo 'GUIs stopped'


# TODO: create shared functionality across scripts
# TODO: clean this up
if [[ $1 != "" ]]; then
  echo "Arg(s) detected, keeping config in place"
else
  mgmt_file='/etc/gdm3/bash-managed.txt'

  x11_mgmt_file='/etc/X11/bash-managed.txt'

  if [[ -f "$mgmt_file" ]]; then
    sudo rm "$mgmt_file"

    bak_file="/etc/gdm3/custom.conf.bak"
    cmd="mv"

    if [[ ! -f "$bak_file" ]]; then
      bak_file="/etc/gdm3/custom.conf.OG.bak"
      cmd="cp"
    fi
    sudo $cmd "$bak_file" /etc/gdm3/custom.conf
    echo 'cleaned configs'
  else
    echo 'Management file not found! NOOP!'
  fi

  if [[ -f "$x11_mgmt_file" ]]; then
    sudo rm "$x11_mgmt_file"

    bak_file="/etc/X11/Xwrapper.config.bak"
    cmd="mv"

    if [[ ! -f "$bak_file" ]]; then
      bak_file="/etc/X11/Xwrapper.config.OG.bak"
      cmd="cp"
    fi
    sudo $cmd "$bak_file" /etc/X11/Xwrapper.config
    echo 'cleaned configs'
  else
    echo 'X11 management file not found! NOOP!'
  fi

fi

echo 'Remote GUI stop finish.'
