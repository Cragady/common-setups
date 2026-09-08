# VirtualBox: drag and drop to guest fails (Guest Additions missing)

Hit on a Windows 10 guest (`win10-playground`) under VirtualBox 7.2.6. The same
diagnosis applies to shared clipboard, shared folders, and seamless mode --
all of them are Guest Additions features, not host features.

Unrelated to `virtualbox_and_mokutil.md` (module signing) and
`virtualbox_hostonly_network_range.md` (host-only address whitelist).

## Issue

```
DnD: Error: Drag and drop to guest not possible -- either the guest OS does not
support this, or the Guest Additions are not installed.

Result Code:   VBOX_E_DND_ERROR (0x80bb0011)
Component:     GuestDnDTargetWrap
```

The message is *literally true*, and worth believing before hunting elsewhere.

## Diagnosis

Guest Additions report their version into guest properties. If GA is installed
and its service is running, these are populated. If GA is absent, they are not:

```sh
VBoxManage guestproperty get <vm> /VirtualBox/GuestAdd/Version
VBoxManage guestproperty get <vm> /VirtualBox/GuestInfo/OS/Product
# No value set!      <-- GA is not running in the guest
```

Careful: `VBoxManage guestproperty enumerate <vm>` may still list
`/VirtualBox/GuestAdd/GuiOnFocus`. That one is set by the **host** GUI, not the
guest, so its presence does *not* mean GA is installed.

Confirm the host-side toggle isn't the culprit -- this is a separate setting
from GA, and it was already correct here:

```sh
VBoxManage showvminfo <vm> | grep -iE 'drag|clipboard'
# Drag and drop Mode:   HostToGuest
# Clipboard Mode:       disabled
```

Check whether a *matching* GA ISO even exists on the host:

```sh
ls -l /usr/share/virtualbox/VBoxGuestAdditions.iso
apt-cache policy virtualbox-guest-additions-iso
```

An old `VBoxGuestAdditions_*.iso` sitting in `~/.config/VirtualBox/` is a trap.
There was a `6.1.50` copy from 2024 in there against a `7.2.6` host -- five
major versions of drift. Don't install from it.

## Solution (CLI)

Get the ISO, matched to the host version by the package manager:

```sh
sudo apt install virtualbox-guest-additions-iso
```

Swap it into the VM's DVD slot. Safe to do while the VM is running. Find the
controller name and the optical port first, since they vary per VM:

```sh
VBoxManage showvminfo <vm> --machinereadable | grep -E '^(storagecontrollername|"SATA)'
```

```sh
VBoxManage storageattach <vm> --storagectl SATA --port 1 --device 0 \
  --type dvddrive --medium /usr/share/virtualbox/VBoxGuestAdditions.iso
```

Add `--forceunmount` if the slot is occupied and won't release. On a VM built by
the unattended installer, that slot usually still holds the leftover
`Unattended-<uuid>-aux-iso.viso`.

Set the modes (live, no reboot):

```sh
VBoxManage controlvm <vm> draganddrop bidirectional
VBoxManage controlvm <vm> clipboard mode bidirectional
```

## Solution (GUI)

From the running VM's window, `Devices` menu:

1. `Devices > Insert Guest Additions CD image...`
   * Replaces whatever is in the DVD slot. If it says the disc is in use, click
     **Force Unmount**.
   * If no GA ISO is on the host, VirtualBox offers to **download** it. Accept
     and it fetches the matching version -- this makes the `apt` step optional.
2. `Devices > Drag and Drop > Bidirectional`
3. `Devices > Shared Clipboard > Bidirectional`

Items 2 and 3 are live and are the exact equivalent of the `controlvm` commands
above.

### apt vs. the GUI download

| | |
|---|---|
| GUI download | No password prompt. Lands in `~/.config/VirtualBox/`. |
| `apt install virtualbox-guest-additions-iso` | Stays in sync with the `virtualbox` package on future upgrades, so it won't drift the way the 6.1.50 copy did. |

Prefer apt for the sync-on-upgrade behaviour. The GUI download is fine otherwise.

## The step with no shortcut: install it inside the guest

Neither route installs anything by itself -- they only make the CD available.

**Windows guest:** open the CD drive in Explorer, run `VBoxWindowsAdditions.exe`
**as Administrator**, approve the driver prompts, reboot the guest.

**Linux guest:** needs `build-essential` and matching kernel headers first, then
run `VBoxLinuxAdditions.run` as root from the mounted ISO, then reboot.

DnD only starts working after that guest reboot.

## Verify

```sh
VBoxManage guestproperty get <vm> /VirtualBox/GuestAdd/Version
# Value: 7.2.6      <-- was "No value set!" before
```

## Gotchas

* If the VM window has captured your keyboard and mouse, press the **Host key**
  (right `Ctrl` by default) to reach the menu bar.
* GA version should match the host VirtualBox version. A large gap causes
  exactly these "not installed" symptoms even when something *is* installed.
* Shared clipboard is a separate toggle from DnD. Both need GA, but enabling one
  does not enable the other.
