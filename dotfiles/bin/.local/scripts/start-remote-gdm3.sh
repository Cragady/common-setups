#!/bin/bash

# NOTE: Script doesn't work as-is - needs more work, wayland likes getting in the way
echo "Script doesn't work as-is - needs more work, wayland likes getting in the way"

function prev_cmd_successful() {
  if [ $? -ne 0 ]; then
    echo 'Failure in process. Exiting and cleaning up.'
    stop-remote-gdm3.sh
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

function either_or_file() {
  FILE=$(check_file_exists "/run/user/$(id -u $USER)/gdm/Xauthority")
  if [[ $FILE == "" ]]; then
    FILE=$(check_file_exists "$HOME/.Xauthority")
  fi
  echo "$FILE"
}

echo -e "\n\nWARNING: do not run this script as sudo! Run it as your user.\n\n"
read -t 5 -n 1 -p 'Y/y to continue, anything else will stop the script - [Y/y]: ' key

echo ''

key=$(echo "$key" | tr '[:upper:]' '[:lower:]')
if [[ "$key" != "y" ]]; then
  exit
fi


# TODO: change to be better - don't hard code username (in flyby file)
# use script and replacement string to do this.

mgmt_file="/etc/gdm3/bash-managed.txt"
if [[ ! -f "$mgmt_file" ]]; then
  echo 'Backing up previous gdm/custom.conf'
  sudo cp /etc/gdm3/custom.conf /etc/gdm3/custom.conf.bak
  echo 'Setting up configs.'
  sudo cp $HOME/common-setups/dotfiles/Z_NO_STOW/ZZZZ_FLYBYS/gdm3/custom.autologin.conf /etc/gdm3/custom.conf
  sudo touch "$mgmt_file"
else
  echo 'Management file detected - NOOP!'
fi

stop-remote-gdm3.sh "keep-conf"
sudo systemctl start gdm3

echo "Waiting for X11 session..."

loop_limit=30
loop_iteration=0

current_sessions=$(loginctl list-sessions --no-legend | awk "/$USER/"'{print $1}')

while [[ $loop_iteration -le $loop_limit ]]; do

  while IFS= read -r SESSION_ID; do

    if [ -n "$SESSION_ID" ]; then
      TYPE=$(loginctl show-session "$SESSION_ID" -p Type --value)
      DISPLAY=$(loginctl show-session "$SESSION_ID" -p Display --value)

      if [ "$TYPE" = "x11" ] && [ -n "$DISPLAY" ]; then
        echo "X11 session ready on $DISPLAY"
        break
      fi
    fi
  done <<< "$current_sessions"

  ((loop_iteration++))
  sleep 1
done

# TODO: change to be better - don't hard code username
sudo -u cragady DISPLAY=:0 XAUTHORITY=$(either_or_file) rustdesk &
prev_cmd_successful
echo 'Remote Display for RDP initiated.'
