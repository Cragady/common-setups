kwriteconfig6 --file ~/.config/kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.plasmashell,/PlasmaShell,org.kde.PlasmaShell,activateLauncherMenu"
qdbus6 org.kde.KWin /KWin reconfigure
sudo mount --bind /dev/null /usr/share/dbus-1/services/org.bluez.obex.service
sudo umount /usr/share/dbus-1/services/org.bluez.obex.service
# Or dbus-send --print-reply --dest=org.kde.KWin /KWin org.kde.KWin.reconfigure

