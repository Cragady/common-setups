# Ada

Just for funsies, but we'll be using GCC to use Ada.

## Quick Example

```ada
-- hello.adb
with Ada.Text_IO; use Ada.Text_IO; procedure Hello is begin Put_Line ("Hello, World! :D:D:D:D"); end Hello;
```

```sh
gcc -c hello.adb # -c is needed due to gcc not using its linking capability directly for Ada programs
gnatbind hello
gnatlink hello
./hello
# OR MUCH MORE SIMPLY:
gnatmake hello.adb
./hello
```
