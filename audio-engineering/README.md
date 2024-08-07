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

Or if you need a specific commit:

`make PARALLEL=1 ZYNADDSUBFX_COMMIT=530bb88a74000f9fbd5760be6a86fdeab2a79f85 MODE=release -f Makefile.linux.mk all`

### rubberband

Note: consider what you want rubberband for.

`sudo apt-get install rubberband-ladspa`

Just install it, the below is legacy's sake.

Source: https://github.com/breakfastquay/rubberband

Deps: LADSPA

`sudo apt-get install ladspa-sdk`
`sudo apt-get install lv2-dev`
`sudo apt-get install libsndfile1-dev`

```sh
make -f otherbuilds/Makefile.linux
# OR
meson setup build && ninja -C build
# OR
meson setup build -Dlv2=enabled  && ninja -C build
```

For more build options/info, read the `COMPILING.md` file in the repo.

### swh-lv2

`sudo apt-get install swh-lv2`

### calf

Source: https://github.com/calf-studio-gear/calf

Site: https://calf-studio-gear.org/

Deps:

```sh
# sudo apt-get install libtool autoconf libexpat1-dev libglib2.0-dev libfluidsynth-dev jackd libjack-dev lv2core libglade2-dev lv2-dev
# The above command's lv2core pulls in lv2-dev, may not be neccessary to use lv2core since it's not in the repositories
sudo apt-get install libtool autoconf libexpat1-dev libglib2.0-dev libfluidsynth-dev jackd libjack-dev libglade2-dev lv2-dev
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
sudo make install
```

### kx.studio

[Check the site](https://kx.studio/Repositories) to see if instructions are the same.

```sh
# Update software sources
sudo apt-get update

# Install required dependencies if needed
sudo apt-get install apt-transport-https gpgv wget

# Download package file
cd ~/Downloads
wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_11.1.0_all.deb

# Install it
sudo dpkg -i kxstudio-repos_11.1.0_all.deb
```

* `sudo apt-get install ams-lv2`

### Wolf Shaper

https://github.com/wolf-plugins/wolf-shaper

```sh
sudo apt-add-repository -y ppa:pdesaulniers/wolf
sudo apt-get update
sudo apt-get install wolf-shaper
```

### Misc

* `sudo apt-get install eq10q`
* `sudo apt-get install lsp-plugins-lv2`
* `sudo apt-get install alsa-tools`
* `sudo apt-get install dpf-plugins dpf-plugins-lv2 `
* `sudo apt-get install guitarix`
* `sudo apt-get install zita-at1`
* `sudo apt-get install x42-plugins`

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

### Baudline

https://www.baudline.com/download.html

