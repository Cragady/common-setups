# Overview

This will be a dump of fun packages & tools to install and maybe play around with.

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

