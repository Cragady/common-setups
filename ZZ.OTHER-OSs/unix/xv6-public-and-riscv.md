# Unix V6 MIT Re-implementations

Compile for a qemu target, the makefile should have automatic commands that will automatically start qemu in the following two repos. May have to fudge the Makefiles slightly, especially if adding new and/or custom userspace/kernel program(s).

## xv6-public (Old, 32bit x86)

xv6 is a re-implementation of Dennis Ritchie's and Ken Thompson's Unix
Version 6 (v6).  xv6 loosely follows the structure and style of v6,
but is implemented for a modern x86-based multiprocessor using ANSI C.

`https://github.com/mit-pdos/xv6-public`

## xv6-riscv (New, 64bit risc-v)

xv6 is a re-implementation of Dennis Ritchie's and Ken Thompson's Unix
Version 6 (v6).  xv6 loosely follows the structure and style of v6,
but is implemented for a modern RISC-V multiprocessor using ANSI C.

`https://github.com/mit-pdos/xv6-riscv`

Will need this: `https://github.com/riscv/riscv-gnu-toolchain`. I, personally, added this in the `/opt` directory in a sub-directory that my group and I own (not root), called `/riscv` - (`/opt/riscv`). This toolchain is mentioned in `../../c-cplusplus-and-friends/README.md`
