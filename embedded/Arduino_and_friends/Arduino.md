# Arduino

## CLI

https://github.com/arduino/arduino-cli

```sh
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=~/bin sh
```

## arduino-lint

https://github.com/arduino/arduino-lint

```sh
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-lint/main/etc/install.sh | BINDIR=~/bin sh
```

## arduino-fwuploader

https://github.com/arduino/arduino-fwuploader

https://github.com/arduino/arduino-fwuploader/releases/latest

### Installation

#### Task (If not installed)

```sh
curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.deb.sh' | sudo -E bash
sudo apt-get install task
```

#### arduino-fwuploader

```sh
# In root of source dir
# task dist:<OS>_<ARCH>
task dist:Linux_64bit
ln -s $HOME/program-files/arduino-fwuploader/dist/arduino-fwuploader_linux_amd64/arduino-fwuploader $HOME/bin
```

OS Values: `macOS`, `Windows`, `Linux`
ARCH Values: `32bit`, `64bit`, `ARMv6`, `ARMv7`, `ARM64`

## IDE 2.x

https://github.com/arduino/arduino-ide

## IDE 1.x

https://github.com/arduino/Arduino
