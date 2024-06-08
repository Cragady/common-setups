# Ocaml

[Site](https://ocaml.org/install)
[GitHub](https://github.com/ocaml/ocaml)

## Install

* `sudo apt-get install bubblewrap` # if needed

The install takes just a bit

* `bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"`
* `opam init`
  * If answered no in opam init, needs one of the following
    * `eval $(opam env)`
    * `opam --exec -- [CMD]`
* `opam install ocaml-lsp-server odoc ocamlformat utop`

## Modified Files

~/.zshrc

## Misc


This package requires additional configuration for use in editors. Install package 'user-setup', or manually:

   * for Emacs, add these lines to ~/.emacs:
     (add-to-list 'load-path "/home/cragady/.opam/default/share/emacs/site-lisp")
     (require 'ocp-indent)

   * for Vim, add this line to ~/.vimrc:
     set rtp^="/home/cragady/.opam/default/share/ocp-indent/vim"
