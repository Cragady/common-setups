#!/bin/bash

# Use under tmux for better stability:
# Ctrl+b D # This looks like the tmux binding so):
# IN YOUR CASE IT'S
# Ctrl+a D

echo 'Starting KDE Plasma remotely, clean up with `stop-remote-gui.sh`'

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

# Xorg :0 &
# sleep 3

export LANG="en_US.UTF-8"
export LANGUAGE=
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_ALL=
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=KDE
export DESKTOP_SESSION=plasma
export KDE_FULL_SESSION=true
export QT_QPA_PLATFORM=xcb
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

xinit /bin/sh -c '

  until xset q >/dev/null 2>&1; do
    sleep 0.2
  done

  setxbmap us
  setxbmap -layout us -option ""

  for i in {1..20}; do
    OUT=$(setxkbmap -query | grep layout || true)

    if echo "$OUT" | grep -q "us"; then
      break
    fi

    sleep 0.1
  done

  sleep 1.5

  dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE KDE_FULL_SESSION LANG LC_ALL;
  exec dbus-run-session startplasma-x11
' -- :0 &

loop_limits=30
loop_iter=0

while [[ ! -e /tmp/.X11-unix/X0 && $loop_iter -le $loop_limits ]]; do
  ((loop_iter++))
  sleep 1
done

loop_iter=0

while ! pgrep -u "$USER" plasmashell >/dev/null && [[ $loop_iter -le $loop_limits ]]; do
  ((loop_iter++))
  sleep 1
done

if ! systemctl status rustdesk &> /dev/null; then
  rustdesk &
fi

echo 'Remote Display for RDP initiated.'

