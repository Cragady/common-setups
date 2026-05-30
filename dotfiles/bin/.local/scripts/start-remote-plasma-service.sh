#!/bin/bash

# NOTE: usage
# systemctl --user daemon-reload # force re-read of unit files (like .service files), rerun generators, and rebuild dep tree.
# # NOTE: The above is needed when unit files are created or changed
# systemctl --user status remote-plasma.service # Check the user's service named 'remote-plasma.service'


# NOTE:
# user service needs user manager, check
# loginctl show-user "$USER"
# systemctl --user status
# ps -ef | grep "systemd --user"
# # ps -ef | egrep "(systemd --user|UID          PID    PPID  C STIME TTY          TIME CMD)"
# # ps -ef | grep -v grep | egrep "(systemd --user|UID          PID    PPID  C STIME TTY          TIME CMD)"
# # ps -ef | grep -P '^(?!.*grep).*(systemd --user|UID          PID    PPID  C STIME TTY          TIME CMD)'
# # ps -ef | rg --pcre2 '^(?!.*grep).*(systemd --user|UID          PID    PPID  C STIME TTY          TIME CMD)'
# # ps -ef | rg -P '^(?!.*grep).*(systemd --user|UID          PID    PPID  C STIME TTY          TIME CMD)'
# # --pcre === -P

echo 'Starting KDE Plasma service.'

echo -e "\n\nWARNING: run this as a user only! No sudo!\n\n"


read -t 5 -n 1 -p 'Do you need service persistence after shell session has ended? [y/n]: ' key

key=$(echo "$key" | tr '[:upper:]' '[:lower:]')
if [[ "$key" == "y" ]]; then
  loginctl enable-linger "$USER"
fi

# TODO: mask obex with: `sudo mount --bind /dev/null /usr/share/dbus-1/services/org.bluez.obex.service`
# if it's still problematic. Add the umount command: `sudo umount /usr/share/dbus-1/services/org.bluez.obex.service` in stop-remote-plasma-service.sh script if implemented
# if it's still problematic. Add the umount command: `` in stop-remote-plasma-service.sh script if implemented


echo -e "\n\n"

systemctl --user start xorg.service
systemctl --user start remote-plasma.service
