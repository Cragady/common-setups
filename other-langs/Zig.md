# Zig

[GitHub](https://github.com/ziglang/zig)
[Site](https://ziglang.org/)

## Download

### Download Pre-Req (minisign)

* `wget https://github.com/jedisct1/minisign/releases/download/0.11/minisign-0.11-linux.tar.gz`
* `tar -xvzf minisign-0.11-linux.tar.gz`
* `cp minisign-linux/x86_64/minisign ./`
* Add install path to $PATH in shell user file, or make an alias

### Download Zig

* `mkdir ~/zig`
* `cd ~/zig`
* `wget https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.32+4aa15440c.tar.xz`
* `wget https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.32+4aa15440c.tar.xz.minisig`
* `minisign -Vm zig-linux-x86_64-0.14.0-dev.32+4aa15440c.tar.xz -P RWSGOq2NVecA2UPNdBUZykf1CCb147pkmdtYxgb3Ti+JO/wCYvhbAb/U`
* `tar -xvJf zig-linux-x86_64-0.14.0-dev.32+4aa15440c.tar.xz`
* `mkdir zipped 0.14.0 # or the version you downloaded`
* `mv zig-linux-x86_64-0.14.0-dev.32+4aa15440c.tar.xz zipped`
* `mv zig-linux-x86_64-0.14.0-dev.32+4aa15440c.tar.xz.minisig zipped`
* `mv zig-linux-x86_64-0.14.0-dev.32+4aa15440c/* ./0.14.0`
* `rmdir zig-linux-x86_64-0.14.0-dev.32+4aa15440c`
* Add install path to $PATH in shell user file, or make an alias
  * export PATH=$PATH:~/zig/0.14.0

## Modified Files

~/.zshrc
