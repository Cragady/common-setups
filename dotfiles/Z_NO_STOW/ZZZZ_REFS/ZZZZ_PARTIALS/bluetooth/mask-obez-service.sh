# NOTE: Mounting to /dev/null is only needed due to a lack of a backend for bluetooth
# undo when bluetooth backend exists
sudo mount --bind /dev/null /usr/share/dbus-1/services/org.bluez.obex.service
# To undo: sudo umount /usr/share/dbus-1/services/org.bluez.obex.service

