# Assembly

## NASM

Netwide Assembler

x86, x86-64

Written in `C` and `Assembly`.

16-bit, 32-bit, and 64-bit programs.

One of the most popular assemblers for Linux and x86 chips.

### Repo

[nasm](https://github.com/netwide-assembler/nasm)

### Install

`sudo apt-get install nasm`

## MIPS

### Install

`sudo apt-get install gcc-mips-linux-gnu g++-mips-linux-gnu`
`sudo apt-get install binutils-mips-linux-gnu`

#### Emulator Install

`sudo apt-get install spim`
`sudo apt-get install gxemul # multi architecture`

#### Example 1

```asm
  .file 1 "hello.s"
  .data
out_string:  .asciiz "\nHello, World!\n"
  .text
  .globl main
main:
  li $v0, 4
  la $a0, out_string
  syscall
  li $v0, 10
  syscall
```

`spim -file hello.s`

#### Example 2

```c
// main.c

/*
 *  GXemul demo:  Hello World
 *
 *  This file is in the Public Domain.
 */

#include "dev_cons.h"


#ifdef MIPS
/*  Note: The ugly cast to a signed int (32-bit) causes the address to be
	sign-extended correctly on MIPS when compiled in 64-bit mode  */
#define	PHYSADDR_OFFSET		((signed int)0xa0000000)
#else
#define	PHYSADDR_OFFSET		0
#endif


#define	PUTCHAR_ADDRESS		(PHYSADDR_OFFSET +		\
				DEV_CONS_ADDRESS + DEV_CONS_PUTGETCHAR)
#define	HALT_ADDRESS		(PHYSADDR_OFFSET +		\
				DEV_CONS_ADDRESS + DEV_CONS_HALT)


void printchar(char ch)
{
	*((volatile unsigned char *) PUTCHAR_ADDRESS) = ch;
}


void halt(void)
{
	*((volatile unsigned char *) HALT_ADDRESS) = 0;
}


void printstr(char *s)
{
	while (*s)
		printchar(*s++);
}


void f(void)
{
	printstr("Hello world\n");
	halt();
}

```

```c
// dev_cons.h

#ifndef	TESTMACHINE_CONS_H
#define	TESTMACHINE_CONS_H

/*
 *  Definitions used by the "cons" device in GXemul.
 *
 *  This file is in the public domain.
 */


#define	DEV_CONS_ADDRESS		0x0000000010000000
#define	DEV_CONS_LENGTH			0x0000000000000020
#define	    DEV_CONS_PUTGETCHAR		    0x0000
#define	    DEV_CONS_HALT		    0x0010


#endif	/*  TESTMACHINE_CONS_H  */

```

GCC Compiling: 

`mips-linux-gnu-gcc -DMIPS main.c -mfp32 -mips1 -mabi=32 -c -o hello_mips32.o`
`mips-linux-gnu-ld -Ttext 0x80030000 -e f hello_mips32.o -o hello_mips32`
`gxemul -E testmips -C R2000 hello_mips32`

G++ Compiling:

Get entry point from ASM file:

There are two differences between main.cpp and main.c. In the main function, define the string literal:

```c
char const *msg = "Hello, World!\n";
printstr(msg);
```

And change the signature of `printstr` to receive the new variable type.

```c
void printstr(char const *s)
```

`mips-linux-gnu-g++ -DMIPS main.cpp -mfp32 -mips1 -mabi=32 -c -o hello_mips32.o`
`mips-linux-gnu-ld -Ttext 0x80030000 -e _Z1fv hello_mips32.o -o hello_mips32`
`gxemul -E testmips -C R2000 hello_mips32`

To get ASM files: 

`mips-linux-gnu-gcc -DMIPS -S main.c -mfp32 -mips1 -mabi=32 -c -o hello_mips32.s`
`mips-linux-gnu-g++ -DMIPS -S main.cpp -mfp32 -mips1 -mabi=32 -c -o hello_mips32.s`

## Others



