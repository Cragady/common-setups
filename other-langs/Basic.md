# Basic / Visual Basic

## Install(s)

* `sudo apt-get install yabasic`
  * Interpreter
* `dotnet` (Install in other file, search repo)

## Compiling/Interpreting

Use `yabasic` for an interpreter, use `dotnet` for Visual Basic

## File Extension(s)

* `.bas`


## Example (yabasic)

```basic
' hello.bas
clear screen
print "Press 'q' to quit ..."
label again
print color("green") "Hello ";
print color("blue") "World !   ";
if (inkey$(1)="q") exit
goto again
```

```sh
yabasic hello.bas
```

## Example (Visual Basic - .NET)

```sh
dotnet new console -lang VB
dotnet run
```

## Other Implementations

### QB64

[GitHub](https://github.com/QB64Official/qb64)
[Site](https://qb64.com/)

### FreeBasic

This requires dependencies that are legacy, and won't currently be used.

* libtinfo5
* libgpm-dev

[Site](https://www.freebasic.net/)
[GitHub](https://github.com/freebasic/fbc)
[SourceForge](https://sourceforge.net/projects/fbc/files/)


* `https://sourceforge.net/projects/fbc/files/`

#### Dependencies

To check if installed:

```sh
apt list --installed | egrep -i \
  -e "gcc|libncurses5-dev|libffi-dev|libgl1-mesa-dev" \
  -e "libx11-dev|libxext-dev|libxrender-dev|libxrandr-dev|libxpm-dev" \
  -e "libtinfo5|libgpm-dev" # | less # for interactive
```

#### Install

* `git clone git@github.com:freebasic/fbc.git`

DNF
