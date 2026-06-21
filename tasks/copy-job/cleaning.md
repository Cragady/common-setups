# Misc Happenings

```sh
sudo systemctl daemon-reload
sudo systemctl start copy-games.service
sudo systemctl status copy-games.service 
systemctl status copy-games.service
systemctl show --property=MemoryCurrent copy-games.service
systemctl status copy-games.service
sudo systemctl status copy-games.service
systemctl status copy-games.service

systemctl --user status remote-plasma.service
history | egrep "systemctl.*enable"
history | egrep "systemctl.*(enable|disable)"
sudo systemctl status sddm
history | egrep "systemctl.*(enable|disable).*sddm" -A 5
history | egrep "systemctl.*(enable|disable).*sddm" -A 10
history | egrep "systemctl.*(enable|disable).*sddm" -A 35
sudo systemctl stop sddm
sudo systemctl disable sddm
sudo systemctl status display-manager
sudo systemctl status display-manager.service

systemctl status copy-games.service
systemctl status copy-job
systemctl status copy-games.service 
systemctl show -P ExecMainStatus copy-games.service
systemctl show copy-games.service
systemctl show -P MainPid,ExecMainStatus copy-games.service
systemctl show copy-games.service | egrep -i "(pid,mainstatus)"
systemctl show copy-games.service | egrep -i status
systemctl show copy-games.service | egrep -i "(pid|mainstatus)"
systemctl status copy-games.service
systemctl --user status remote-plasma.service
```
