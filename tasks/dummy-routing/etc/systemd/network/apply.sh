# Likely won't be needed
sudo systemctl enable systemd-networkd
sudo systemctl restart systemd-networkd

# Verify
ip addr show dummy0
