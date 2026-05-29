#!/bin/bash

# Use under tmux for better stability:
# Ctrl+b D # This looks like the tmux binding so):
# IN YOUR CASE IT'S
# Ctrl+a D

function prev_cmd_successful() {
  if [ $? -ne 0 ]; then
    echo 'Failure in process. Exiting and cleaning up.'
    stop-remote-gui.sh
    exit 1
  fi
}

function check_file_exists() {
  if [[ -f "$1" ]]; then
    echo "$1"
  else
    echo ""
  fi
}

echo -e "\n\nWARNING: do not run this script as sudo! Run it as your user.\n\n"
read -t 5 -n 1 -p 'Y/y to continue, anything else will stop the script - [Y/y]: ' key

echo ''


mgmt_file="/etc/X11/bash-managed.txt"
if [[ ! -f "$mgmt_file" ]]; then
  echo 'Backing up previous X11/Xwrapper.config'
  sudo cp /etc/X11/Xwrapper.config /etc/X11/Xwrapper.config.bak
  echo 'Setting up configs.'
  sudo cp $HOME/common-setups/dotfiles/Z_NO_STOW/ZZZZ_FLYBYS/X11/Xwrapper.config /etc/X11/Xwrapper.config
  sudo touch "$mgmt_file"
else
  echo 'Management file detected - NOOP!'
fi

stop-remote-gui.sh "keep-conf"

export DISPLAY=:0

# Xorg :0 &
# sleep 3

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=XFCE
export DESKTOP_SESSION=xfce

xinit /bin/sh -c 'exec dbus-run-session startxfce4' -- :0 &
prev_cmd_successful

# dbus-launch startxfce4 &

loop_limits=30
loop_iter=0

while [ ! -e /tmp/.X11-unix/X0 ]; do
  sleep 1
done

loop_iter=0

while ! pgrep -u "$USER" xfce4-session >/dev/null; do
  sleep 1
done

rustdesk &
prev_cmd_successful
echo 'Remote Display for RDP initiated.'
