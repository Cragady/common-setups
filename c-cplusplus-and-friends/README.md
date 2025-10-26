# Overview

This should get you started with c and friends with maybe one or two quality of life items.

* sudo apt-get install build-essential   # Gets you gcc & g++ & make
* sudo apt-get install libstdc++-12-dev  # Helps with Neovim + Mason LSP for c++
* sudo apt-get install valgrind          # Tool for checking memory usage of application
* sudo apt-get install cmake             # Tool for building c/c++ applications
* extra-cmake-modules                    # Extra cmake modules

## c/c++ package manager(s)

* git submodules
* [vcpkg](https://learn.microsoft.com/en-us/vcpkg/get_started/get-started?pivots=shell-bash)
* [conan](https://conan.io/downloads)

### vcpkg

I have three dirs for tools:

* ~/Toolkits
* ~/dev2/Tools
* ~/dev2/tools-and-things

I'll likely use ~/Toolkits for this.

[vcpkg](https://learn.microsoft.com/en-us/vcpkg/get_started/get-started?pivots=shell-bash)

* git clone https://github.com/microsoft/vcpkg.git ~/Toolkits/vcpkg
* cd ~/Toolkits/vcpkg && ./bootstrap-vcpkg.sh -disableMetrics

```sh
export VCPKG_ROOT=/path/to/vcpkg
export PATH=$VCPKG_ROOT:$PATH
```

Below should be in .zshrc, or whatever config file for your shell env that loads in when opened.
```sh
export VCPKG_ROOT=~/Toolkits/vcpkg
export PATH=$VCPKG_ROOT:$PATH
```

## RISC-V

`git clone https://github.com/riscv/riscv-gnu-toolchain`

### Ubuntu Prerequisites

```sh
$ sudo apt-get install autoconf automake autotools-dev curl python3 python3-pip python3-tomli libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev
```

#### Helper Script Setup Testing Environment Prerequisite

```sh
sudo apt-get install python3-pyelftools
```

### Newlib (Installation - Cross-Compiler)

Pick a writeable install path, like `/opt/riscv` - If another path is specified, change the value below

```sh
./configure --prefix=/opt/riscv
make
```

### Newlib/Linux multilib

For 32-bit and 64-bit support

```sh
./configure --prefix=/opt/riscv --enable-multilib
make
# OR (or both?)
make linux
```

## GUI/GPU/Other Friends (Doesn't have to be c/c++ specific)

Some of these will be cross-platform, where others will not. Some are libs, some are specifications, be sure to choose wisely with what you want to do. Some will be really old, and will need to have a new technology/api/spec used instead.

* [RmlUi](https://github.com/mikke89/RmlUi)
* [imgui](https://github.com/ocornut/imgui)
* [hikogui](https://github.com/hikogui/hikogui)
* [Chromium Embedded Framework](https://bitbucket.org/chromiumembedded/cef-project/src/master)
  * https://bitbucket.org/chromiumembedded/cef/wiki/Tutorial
  * Maybe not this (Might be fun)
* OpenGL
* OpenCL
* Vulkan
* GLFW
* GLEW
* GLAD
* SDL2
* GTK+
  * Others: GTK, GTK2, GTK+ 3/GTK3, GTKmm
* qt
* fltk
* Glade
* Metal (Apple)
* DirectX (Windows)
  * Direct3D
* Windows API (Yuck)

## Misc

* https://cmake.org/
* https://www.gnu.org/software/make/manual/make.html
* https://github.com/KhronosGroup
* https://www.khronos.org/
