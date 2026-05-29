Filenames in this dir have the following formatting rules

This nomenclature is sloppy, but I don't care. I just need it to make sense to me.

* Of course, create `.bak` files where you make changes on the actual system(s)
  * (Optional): remove all write permissions of the `.bak` files.
  * (Optional): make file immutable: `sudo chattr +i /path/to/file`
    * (Optional): to make file mutable again: `sudo chattr -i /path/to/file`
  * The optional steps are to protect wanted files from being clobbered by a root script. If you like flying by the seat of your pants though, don't do this.
* If something is in a subdir, or subdirs, that is not named `ZZZZ_FLYBYS/` or `ZZZZ_PARTIALS/` in the first level of this dir, it's for organizational purposes only
* `ZZZZ_FLYBYS/` are files that should not be used at all outside of a scripting context. `ZZZZ_FLYBYS/` should be considered temporary config files that are replaced by the previous config when the task/sub-task at hand is finished and no longer requires the config(s) specified in `ZZZZ_FLYBYS/*`. 
* subdir, or subdirs, in `ZZZZ_FLYBYS/` should be considered organizational only
* In the wanted destination of the files, `-` means a forward slash `/`.
* `_` means a dash - `-`
* If a file path doesn't start at root for whatever reason, that will be specified between two `.`s at the end of the filename and the beginning of the filename extension.
  * e.g. `doop-derp.noroot.txt`, `doop-derp.noroot-root-is-project-dir.txt`, or something like that.
* `ZZZZ_FLYBYS/` operates with the same rules as the top dir, but files in this dir show that the files should be changed in only very specific places or settings
  * `ZZZZ_FLYBYS/` will also include scripts with no pathed names to show what needed to be done to attain setup wanted.
