# Arduino

The following will likely be needed:

```sh
sudo usermod -a -G dialout "$USER"
```

```sh
# After you have the board connected to the tty, this may be needed as well:
sudo chmod a+rw /dev/ttyACM0
# OG perms is 660, or 620
```

## CLI

https://github.com/arduino/arduino-cli

```sh
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=~/bin sh
```

## arduino-language-server

https://github.com/arduino/arduino-language-server

```sh
# go install github.com/arduino/arduino-language-server@${VERSION}
# go install github.com/arduino/arduino-language-server@latest
go install github.com/arduino/arduino-language-server@0.7.7 # or most current version
ln -s $HOME/go/bin/arduino-language-server ~/bin
```

### Potential IDE Initiating

```sh
# NOTE: some args will be different
./arduino-language-server \
 -clangd /usr/local/bin/clangd \
 -cli /usr/local/bin/arduino-cli \
 -cli-config $HOME/.arduino15/arduino-cli.yaml \
 -fqbn arduino:mbed:nanorp2040connect
```

## IO/Serial from CLI Instead of IDE

To read from Arduino's serial port, you'll need to set `stty` to have the same input/output speeds that Arduino's Serial is set to:

```sh
# Serial.begin(9600); Can be any number, not just 9600, as long as the below command reflects this
stty -F /dev/ttyACM0 raw 9600 # Could be another device, not just /dev/ttyACM0
# And to read:
cat /dev/ttyACM0
```

After using the `stty` command, you'll be able to see the Serial outputs from Arduino. This won't work super well when a shell is emulated in the Neovim environment.

To send messages to the Aruino, just use echo:

```sh
echo high > /dev/ttyACM0 # Or any input you need to send
```

Occasionally this doesn't work quite as expected and for some reason repeats the input and/or output. Unsure if this is an issue setting up communication between the Aruino and linux, an issue with the Arduino's hardware, or an issue in the program uploaded to the Arduino.

This may have more to do with the communication setup with the Arduino. `arduino-cli monitor` works perfectly for two way communication.

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

https://www.arduino.cc/en/software

Uses `libsecret`

```sh
sudo apt-get install libsecret-1-dev
```

Or just download it.

## IDE 1.x

https://github.com/arduino/Arduino
