# Overview

This setup assumes Ubuntu as the linux distro in use. If you are on a different distro, follow the required steps for that distro instead.

I like to put the following repos within a `/sources` dir within my user dir.

I also like to group them as such:

`~/sources/ardour` - Ardour
`~/sources/audio-plugins/zynaddsubfx/zynaddsubfx` - zynaddsubfx
`~/sources/audio-plugins/zynaddsubfx/zyn-fusion-build` - zyn-fusion-build
etc.

I just put Ardour in the top level for reasons.

There are a few audio plugins I'm interested in, and it makes sense to make a sub-dir to hold these repos. I also like to have these repos live within groupings if there are multiple repos I'm cloning from the same users/organizations.

## Some Setup

### Ardour

`sudo apt-get install ardour`

Sources: https://github.com/Ardour

### DrumGizmo

`sudo apt-get install drumgizmo`

Link: https://drumgizmo.org/wiki/doku.php?id=getting_drumgizmo

Other: https://www.drumgizmo.org/wiki/doku.php?id=kits:drskit

```sh
wget -P ~/sources/drumgizmo https://drumgizmo.org/kits/DRSKit/DRSKit2_1.zip
md5sum -c <<< "8c4d4b61ad9d354b3b845edd5da9c133 $HOME/sources/drumgizmo/DRSKit2_1.zip"
```

```sh
cd ~/sources/drumgizmo
unzip DRSKit2_1.zip
cd -
```

Usage: https://linuxaudio.github.io/libremusicproduction/html/tutorials/setting-and-using-drumgizmo-ardour

### ZynAddSubFx / zyn-fusion-build

Source: https://github.com/zynaddsubfx/zyn-fusion-build

Follow the instructions for installation. One difference, for the make command, enter the following: 

`make PARALLEL=1 MODE=release -f Makefile.linux.mk all`

## Future Installations

### sfizz-ui / sfizz

https://github.com/sfztools/sfizz-ui

https://github.com/sfztools/sfizz

### dexed

https://github.com/asb2m10/dexed

### setBfree

https://github.com/pantherb/setBfree
https://setbfree.org/index.html

### VCVRack

https://github.com/VCVRack

### vital

https://github.com/mtytel/vital

### odin2

https://github.com/TheWaveWarden/odin2

