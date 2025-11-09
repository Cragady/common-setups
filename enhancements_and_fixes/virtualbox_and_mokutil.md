# Unsigned Virtual Box - Mokutil

This, or the last steps of this, may have to be done on every kernel update.

## Issue

`sudo modprobe vboxdrv` returns the error: `modprobe: ERROR: could not insert 'vboxdrv': Key was rejected by service`.

Attempting to start a Virtual Machine in `Virtual Box` give the following error: `Kernel driver not installed (rc=-1908)`

## Solution (ACTUAL SOLUTION)

### Find Original Signing Key

https://askubuntu.com/questions/1537180/modprobe-vboxdrv-could-not-insert-vboxdrv-key-was-rejected-by-service

Installing `virtual-dkms` triggers a kernal module signing process. The key that is used here was created on the laptop version of this installation before it was cloned over to a different stick to throw on the desktop.

```sh
sudo mokutil --import /var/lib/shim-signed/mok/MOK.der
```

### Reinstall and Reconfigure

```sh
sudo apt-get install --reinstall virtualbox-dkms
```

```sh
sudo modprobe vboxdrv
```

```sh
sudo dpkg-reconfigure virtualbox-dkms
sudo dpkg-reconfigure virtualbox
```

```sh
sudo modprobe vboxdrv
```

### Attempt to run vboxdrv setup Script Directly

```sh
sudo /etc/init.d/vboxdrv setup
# For more info on what is happening
dmesg | less
```

May have to install from direct source if this still doesn't work.

## Solution (2)

https://stackoverflow.com/questions/38437264/i-cant-execute-command-modprobe-vboxdrv

### Create File Directories

Create a directory where you'll want to keep the certs:

```sh
mkdir -p ~/.certs/virtual_box_vboxdrv
```

### Install mokutil

```sh
sudo apt-get update
sudo apt-get upgrade -y # If needed
sudo apt-get install mokutil
```

### Generate the Signature File

```sh
# NOTE: consider using root user to do this, and chmod MOK.priv
# mkdir /root/module-signing
# cd /root/module-signing
# openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=YOUR_NAME/"
# [...]
# chmod 600 MOK.priv
# The below isn't necessarily needed, or rather shouldn't be encouraged for 
cd ~/.certs/virtual_box_vboxdrv
openssl req -new -x509 -newkey rsa:2048 -keyout MOK_VIRTUAL_BOX_VBOXDRV.priv -outform DER -out MOK_VIRTUAL_BOX_VBOXDRV.der -nodes -days 36500 -subj "/CN=VirtualBox/"
```

### Add it to the Kernel

```sh
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK_VIRTUAL_BOX_VBOXDRV.priv ./MOK_VIRTUAL_BOX_VBOXDRV.der $(modinfo -n vboxdrv)

sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK_VIRTUAL_BOX_VBOXDRV.priv ./MOK_VIRTUAL_BOX_VBOXDRV.der $(modinfo -n vboxnetflt)

sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK_VIRTUAL_BOX_VBOXDRV.priv ./MOK_VIRTUAL_BOX_VBOXDRV.der $(modinfo -n vboxnetadp)

# NOTE: virtualbox removed the following module after a certain version because only a few users needed it.
# sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MOK_VIRTUAL_BOX_VBOXDRV.priv ./MOK_VIRTUAL_BOX_VBOXDRV.der $(modinfo -n vboxpci) # NOT FOUND
```

### Register it for Secure Boot

IMPORTANT: this will ask you for a password, which is optional, but you will only have to use it once in the next reboot.

The password may not be so optional, there is a minimum length of 1 character for the password.

```sh
sudo mokutil --import MOK_VIRTUAL_BOX_VBOXDRV.der
```

### Restart Computer

There will be a blue screen that appears with a keyboard wait. Press the key that asks to interrupt boot.

Inside blue screen, select:

```
Enroll Mok > Continue > Yes > |it will ask for the password here if previously entered| > Reboot
```

### Wrong Solution

Keeping this here as a potential workaround for other things, but this didn't address the issue.

Delete the mokutil with cli, reboot, and at the blue screen enter password the password that was set in the cli command to delete.

## Misc

```sh
See "systemctl status virtualbox.service" and "journalctl -xeu virtualbox.service" for details
.

```
