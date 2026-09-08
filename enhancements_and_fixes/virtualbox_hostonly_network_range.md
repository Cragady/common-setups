# VirtualBox host-only adapter: "Failed to change host network interface parameter"

Hit when changing a host-only adapter's IPv4 address in the VirtualBox Manager
GUI (Tools > Network) to something outside `192.168.56.0/21`.

Unrelated to the Secure Boot / module signing problem in
`virtualbox_and_mokutil.md`, despite both surfacing in the same GUI. Check that
one first if `/dev/vboxdrv` or `/dev/vboxnetctl` is missing.

## Issue

```
Failed to change host network interface parameter.

Callee RC:
E_ACCESSDENIED (0x80070005)
```

Same thing from the CLI:

```sh
VBoxManage hostonlyif ipconfig vboxnet1 --ip 192.168.2.1 --netmask 255.255.255.0
# VBoxManage: error: Code E_ACCESSDENIED (0x80070005) - Access denied
# VBoxManage: error: Context: "EnableStaticIPConfig(...)" at line 252 of file VBoxManageHostonly.cpp
```

## Cause

`VBoxSVC` hands the address change to the setuid helper
`/usr/lib/virtualbox/VBoxNetAdpCtl`, which refuses any host-only address outside
an allowed range. The ranges come from `/etc/vbox/networks.conf`. **When that
file does not exist, VirtualBox falls back to a built-in default of
`192.168.56.0/21`** -- i.e. only `192.168.56.0` through `192.168.63.255`.

Both the path and the default are visible in the helper itself:

```sh
strings /usr/lib/virtualbox/VBoxNetAdpCtl | grep -E '/etc/vbox|192\.168|permission'
# /etc/vbox/networks.conf
# 192.168.56.1/21
# Error: permission denied
```

`E_ACCESSDENIED` is a misleading rendering of that helper's `permission denied`.
It is **not** a filesystem permission problem.

### This is why running VirtualBox as root does not help

The whitelist is read from a file on disk, not derived from your privileges.
Root gets rejected exactly the same way. Don't bother -- and note root has its
own `/root/.config/VirtualBox`, so a root GUI session isn't even looking at the
same VMs or adapters you are.

## Confirm it before changing anything

Call the helper directly. Compare a rejected address against one inside the
default range:

```sh
/usr/lib/virtualbox/VBoxNetAdpCtl vboxnet1 192.168.2.1  netmask 255.255.255.0
# Error: permission denied      (exit 38)
/usr/lib/virtualbox/VBoxNetAdpCtl vboxnet1 192.168.57.1 netmask 255.255.255.0
#                               (exit 0)
```

Re-applying an adapter's *existing* address is a safe no-op, so use the address
it already has as the control. Check current addresses first:

```sh
VBoxManage list hostonlyifs
```

## Solution

Create the file with the range you want, keeping the default so existing
`192.168.56.x` / `57.x` adapters don't break:

```sh
sudo install -d /etc/vbox
printf '* 192.168.56.0/21 192.168.2.0/24\n' | sudo tee /etc/vbox/networks.conf

## In my specific case, the file already existed

sudo install -Dm644 /tmp/vbox-networks.conf /etc/vbox/networks.conf
```

Takes effect immediately -- `VBoxNetAdpCtl` re-reads the file on every
invocation, so no `VBoxSVC` restart and no reboot:

```sh
VBoxManage hostonlyif ipconfig vboxnet1 --ip 192.168.2.1 --netmask 255.255.255.0
```

### File format

* `*` lines list **allowed** ranges, space-separated. IPv4 and IPv6 both allowed.
* `!` lines list **exclusions**.

```
* 10.0.0.0/8 192.168.0.0/16
* 2001::/64
! 10.1.0.0/16
```

`* 0.0.0.0/0` allows everything. It works, but it defeats the point of the
whitelist -- prefer naming the ranges you actually use.

## Gotcha: pick a range that doesn't collide with your real LAN

A host-only adapter sharing a subnet with your physical network causes routing
grief. Check before choosing:

```sh
ip -4 route | grep -E '^default|192\.168|^10\.|^172\.'
# default via 192.168.0.1 dev enp8s0 proto dhcp src 192.168.0.241 metric 100
```

`192.168.0.x` and `192.168.1.x` are the usual router defaults, and `192.168.2.x`
is a common third. If this machine ever moves onto such a network, revisit this.
