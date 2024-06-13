# Cobol

[Packages Ubuntu](https://packages.ubuntu.com/noble/gnucobol)

## Install

* `sudo apt-get install gnucobol`

## File Extensions

* Source File
  * `.cob`
  * `.cbl`
* Copybook
  * `.cbl`
  * `.cpy`

## Example

```cobol
       *> hello.cbl
       IDENTIFICATION DIVISION.
       PROGRAM-ID. IDSAMPLE.
       ENVIRONMENT DIVISION.
       PROCEDURE DIVISION.
           DISPLAY 'Hello, World!'.
           STOP RUN.
```

```sh
cobc -x hello.cbl
./hello
```

## Docs

* https://gnucobol.sourceforge.io/guides.html
* https://gnucobol.sourceforge.io/doc/gnucobol.html
