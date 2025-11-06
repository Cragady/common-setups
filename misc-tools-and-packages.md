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

```sh
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

## CPU Emulation+

GCC may not cut it here, May want clang:

`sudo apt-get install clang lld`

### Unicorn

[Unicorn](https://github.com/unicorn-engine/unicorn)
Compile. Reqs:
  * `sudo apt install cmake pkg-config`

```sh
git clone git@github.com:unicorn-engine/unicorn.git
cd unicorn
mkdir build; cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make
```

Use libs & executables how they should be used.

### qemu
[qemu](https://www.qemu.org/download/#linux)

* Emulating Full System: `apt-get install qemu-system`
* Emulating Linux binaries: `apt-get install qemu-user-static`

## Virtualization

### Virtual Machine Manager

Interacts w/qemu

`sudo apt-get install virt-manager`

### Wine

Windows Emulation

This one it may be better to follow the install instructions on the wine website.

`sudo apt-get install wine`
    
### Virtual Box (Oracle (ew, but Virtual Box is fun))

Just follow the current steps for the wanted platform at: https://www.virtualbox.org/wiki/Linux_Downloads

## FZF, CLI Fuzzy Finder

[GitHub](https://github.com/junegunn/fzf)

`sudo apt-get install fzf`

## cheat.sh

[GitHub(https://github.com/chubin/cheat.sh)
[Site](https://cht.sh)
[Site](https://cheat.sh)

Can Curl against, or host locally.

## stow

Local package manager

`sudo apt-get install stow`

## fd-find (fd)

[GitHub](https://github.com/sharkdp/fd)

Alternative to find. Lighter and faster, but doesn't support as much functionality.

Binary is called `fdfind` instead of `fd` on other systems. `fd` is already reserved for another package.

`sudo apt-get install fd-find`

## xfce4-terminal

`sudo apt-get install xfce4-terminal`

## tilix

Terminal emulator w/tiling.

`sudo apt-get install tilix`

## gnome-multi-writer

Bootable USBs (Debian)

Can also use `gnome-disk-utility`

`sudo apt-get install gnome-multi-writer`

## neofetch

`sudo apt-get install neofetch`

Shows some linux, distro, & computer specs.

## Clamav

Antivirus/Scanner

`sudo apt-get install clamav`

## tcsh

Just a shell

`sudo apt-get install tcsh`

## Stopwatch

`sudo apt-get install stopwatch`

## Subversion

`svn`, source control software.

`sudo apt-get install subversion`

## GIMP

`sudo apt-get install gimp`

## Webp

`sudo apt-get install webp`

## Shotcut

[GitHub Repo](https://github.com/mltframework/shotcut)
[Download](https://www.shotcut.org/download/)

## FontForge

[GitHub Repo](https://github.com/fontforge/fontforge?tab=License-1-ov-file)
[Site](https://fontforge.org/en-US/)

### Ubuntu Install

`sudo apt-get install fontforge`

### Windows Download

[Download](https://fontforge.org/en-US/downloads/windows/)

## xclip

`sudo apt-get install xclip`

## xsel

`sudo apt-get install xsel`

## Deno

```c
// Todo: Move to appropriate location eventually
```

`curl -fsSL https://deno.land/install.sh | sh`

Windows:
`choco install deno`

## Task

https://taskfile.dev

https://github.com/go-task/task

https://taskfile.dev/docs/installation

Modern task runner inspired by Make.

Cross-platform build tool.

```sh
curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.deb.sh' | sudo -E bash
sudo apt-get install task
```

## Homebrew

https://github.com/homebrew

https://brew.sh

Alternative package manager, may conflict with other package managers.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```


