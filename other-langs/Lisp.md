# Lisp

## SBCL (Steel Bank Common Lisp)

* `sudo apt-get install sbcl`

## File Extensions

* `.lisp`
* `.cl`
* `.el` (emacs)
* `.lsp`
* `.l`
* `.fasl` (compiler specific?)

## Example

```lisp
#!/usr/bin/sbcl --script
(write-line "heyooo")
```
```sh
sbcl --script hello.lisp
# Can also be ran from the file itself, if it has a proper shebang
chmod +x hello.lisp
./hello.lisp
```

