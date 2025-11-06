# Fortran

For funsies. I think the toolkit for fortran came with the installation of gcc, if not though, it should be easy enough to figure out how to get it. I'll update later if I can get myself to start up a fresh install in a VM to find out, or something.

## Quick Example

```fortran
! hello.f90
program hello
  print *, 'Hello, World! :D:D:D'
end program hello
```

```sh
gfortran hello.f90 -o hello
./hello
```
