#!/bin/bash

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

echo 'Backing up previous gdm/custom.conf'
sudo cp /etc/gdm3/custom.conf /etc/gdm3/custom.conf.bak

# TODO: change to be better - don't hard code username (in flyby file)
# use script and replacement string to do this.
sudo cp $HOME/common-setups/dotfiles/Z_NO_STOW/ZZZZ_FLYBYS/gdm3/custom.autologin.conf /etc/gdm3/custom.conf

sudo systemctl start gdm3
prev_cmd_successful
sleep 12
prev_cmd_successful

# DISPLAY=:0 XAUTHORITY=/run/user/1000/gdm/Xauthority rustdesk &

# OR:

# TODO: change to be better - don't hard code username
sudo -u cragady DISPLAY=:0 XAUTHORITY=$(either_or_file) rustdesk &
prev_cmd_successful
echo 'Remote Display for RDP initiated.'
