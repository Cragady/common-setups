# Overview

This will be a dump of fun packages & tools to install and maybe play around with.

## Temperature

* `sudo apt-get install lm-sensors`
* `# sudo apt-get install hddtemp`
  * Not on version, use `apt-cache search hddtmep` to find alternative
  * OR:
    * As an alternative to hddtemp, use the following to load the module
    * sudo modprobe -v drivetemp
    * sensors
  * `# sudo apt install smartmontools # if wanted`
  * `gnome-disks`
* `sudo apt install nvme-cli`

### lm-sensors

```sh
sudo sensors-detect # answer defaults
sudo service kmod start
```

### nvme-cli

```sh
# get Node
sudo nvme list
# log
sudo nvme smart-log <Node>
```

## Usage:
sensors

# As an alternative to hddtemp, use the following to load the module
sudo modprobe -v drivetemp
# then execute sensors
sensors
```

## Tree

`sudo apt-get install tree`

## Hex Editors / Dumpers

xxd and hexdump are useful; hexdump can be piped into xxd.

* `sudo apt-get hexedit`

* bless
* DHEX
* wxHexEditor
* ghex
* okteta

### Vim/Neovim

* `:%!xxd` switches to hex mode
* `:%!xxd -r` exits hex mode

### Useful Related Items

* xxd
* hexdump
* objdump
  * `objdump -Slx main.exe > main.asm`
  * Read man pages to use effectively

### Links

https://itsfoss.com/hex-editors-linux/
https://stackoverflow.com/questions/5498197/need-a-good-hex-editor-for-linux
https://en.wikipedia.org/wiki/Comparison_of_hex_editors

## Memory

* https://github.com/cheat-engine/cheat-engine (WINDOWS)
* https://github.com/korcankaraokcu/PINCE
* https://github.com/scanmem/scanmem
  * `sudo apt-get install scanmem`

## Wine

`sudo apt-get install wine`

