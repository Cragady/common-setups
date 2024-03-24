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

### rubberband

Source: https://github.com/breakfastquay/rubberband

Deps: LADSPA

```sh
make -f otherbuilds/Makefile.linux
# OR
meson setup build && ninja -C build
```

For more build options/info, read the `COMPILING.md` file in the repo.

### calf

Source: https://github.com/calf-studio-gear/calf

Site: https://calf-studio-gear.org/

Deps:

```sh
sudo apt-get install libtool autoconf libexpat1-dev libglib2.0-dev libfluidsynth-dev jackd libjack-dev lv2core libglade2-dev lv2-dev
```

Install:

```sh
git clone https://github.com/calf-studio-gear/calf.git
```

Run autogen.sh inside the calf folder to configure the compiling process. If there are errors or missing features at the end check the output, usually there are some packages missing. Run make and make install afterwards. Please note that make install requires superuser rights. The following example is optimized for a dualcore processor. Please edit -j2 to fit your amount of CPU-cores or just don't add it at all.

```sh
cd calf
./autogen.sh
make -j2
make install
```

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

