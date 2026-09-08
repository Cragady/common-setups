# Wine from source (with 32-bit Unix side)

Built 2026-09-07 on Ubuntu 26.04, Wine 11.17, from
`git@gitlab.winehq.org:wine/wine.git`.

Only do this if you need the source build. `sudo apt install wine` is fine
otherwise -- this path pulls ~400 `:i386` `-dev` packages (~1.3 GB) and hits two
Ubuntu Multi-Arch packaging bugs.

## Remove the distro Wine first

```sh
sudo apt purge wine winetricks
sudo apt autoremove --purge
```

Careful with globs: `apt purge "wine*"` matches package names by **substring**,
so it also takes `libwine` and anything else merely containing "wine". Always
dry-run a pattern first:

```sh
sudo apt purge --dry-run "wine*"     # prints the full removal set, changes nothing
```

## Enable i386 and install build deps

```sh
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install gcc-multilib g++-multilib flex bison gettext xorg-dev
sudo apt install g++-mingw-w64-i686 gcc-mingw-w64-i686 \
                 g++-mingw-w64-x86-64 gcc-mingw-w64-x86-64
```

mingw builds the PE-format modules; `gcc-multilib` builds the 32-bit Unix side.
Both are needed.

Then the `-dev` pairs. Install in batches so a failure is easy to localise --
each of these wants both `:amd64` (implicit) and `:i386`:

```
libx11-dev libfreetype-dev libxrender-dev libgnutls28-dev libasound2-dev
libpulse-dev libgl-dev libgles-dev libglu1-mesa-dev freeglut3-dev
libxcursor-dev libxi-dev libxxf86vm-dev libxrandr-dev libxfixes-dev
libxinerama-dev libxcomposite-dev libwayland-dev ocl-icd-opencl-dev
libpcap-dev libpcsclite-dev libdbus-1-dev libsane-dev libusb-1.0-0-dev
libv4l-dev libva-dev libgphoto2-dev libudev-dev libsdl2-dev libsdl3-dev
libcapi20-dev libcups2-dev libfontconfig-dev libkrb5-dev libvulkan-dev
libxtst-dev libxkbcommon-dev libxkbregistry-dev samba-dev
libgstreamer-plugins-base1.0-dev libavcodec-dev libavutil-dev libswresample-dev
```

**`samba-dev:i386` is required** -- it provides
`/usr/lib/i386-linux-gnu/pkgconfig/netapi.pc`. Removing it produces
`configure: libnetapi not found, Samba NetAPI won't be supported`.
It is `Multi-Arch: same`, installs cleanly, and removes nothing. If any tool or
agent claims an i386 `-dev` package will remove your desktop, verify rather than
trust it:

```sh
sudo apt install --dry-run samba-dev:i386
```

## Two packages will fail to co-install

`libpcap0.8-dev` and `libxtst-dev` are `Multi-Arch: same` but ship
arch-differing files at arch-neutral paths. See
[enhancements_and_fixes/multiarch_dev_file_conflicts.md](enhancements_and_fixes/multiarch_dev_file_conflicts.md)
for the diagnosis and the diversion setup. Do that before configure.

## Configure

```sh
./configure
```

Confirm it picked the build you expect:

```sh
grep -c -- '-m32' config.log      # non-zero => 32-bit Unix side is being built
grep 'PE_ARCHS' config.status     # PE arch list
```

Wine resolves libraries via **pkg-config**, not legacy `*-config` scripts, and
`.pc` files live at arch-specific paths -- so a missing `/usr/bin/pcap-config`
does not block the build. For arch-specific lookups the mechanism is
`PKG_CONFIG_PATH=/usr/lib/i386-linux-gnu/pkgconfig` (Debian also ships
`i686-linux-gnu-pkg-config`), or the per-library `FOO_CFLAGS`/`FOO_LIBS`
overrides listed in `./configure --help`.

### Notices you can ignore

- `OSS sound system found but too old (OSSv4 needed)` -- **unsatisfiable and
  irrelevant**. Configure wants `oss_sysinfo.numaudioengines`, an OSSv4-only
  struct member; glibc ships the OSSv3 compat header and OSSv4 is not packaged
  in Ubuntu. OSS is a BSD-era backend. ALSA and PulseAudio are what Wine
  actually uses, and both detect fine. Silence with `--without-oss` if desired.

## Build and install

```sh
make -j$(nproc)          # as your user -- NEVER sudo make
sudo make install        # only this step needs root
sudo ldconfig
```

Never build as root: a root-owned object file in the tree causes confusing
permission failures on the next rebuild.

- prefix is `/usr/local`, which does not collide with distro packages under `/usr`
- `make uninstall` exists, but only works from this tree with matching config --
  don't delete the source directory if you may want to back it out
- budget several GB of disk; the default `-g -O2` carries full debug info

## Wine prefix

`~/.wine` created by an older Wine is upgraded **one-way** on first run of a
newer version. Back it up first if it matters:

```sh
cp -a ~/.wine ~/.wine.bak-<oldversion>
```
