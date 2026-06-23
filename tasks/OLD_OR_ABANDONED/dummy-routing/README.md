# Dummy Routing

The structuring of this dir will tell you where things go. If there is no previously existing file, copy the file to the destination. If there is an existing file, then modify what is already there. The shell scripts just tell you what to execute.

## Important Note

Be sure to change the actual values to the values in your network, and your desired dummy IP.

Right now, the current settings have the following relationship: `10.10.0.2 <-> 192.168.1.2`. This isn't even useful to me. I'd even have to change values to make this work how I want it.

## Full Subnet 

`10.10.0.0/24 <-> 192.168.1.0/24`

## Layout

/etc/
├── default/
│   └── ufw
├── sysctl.d/
│   └── 99-ip-forwarding-for-cloudflare-overlay.conf
├── systemd/
│   └── network/
│       ├── 10-overlay.netdev
│       └── 10-overlay.network
└── ufw/
    └── before.rules
