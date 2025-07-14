# AutoHotKey

[Repo](https://github.com/AutoHotkey/AutoHotkey)

## Default Editor

CLI:

```sh
wt -p "Git Bash" nvim %l
```

NOTE: The above won't correctly load plugins and other settings due to an environment variable being nil. Better to just create and edit normally lol.

## V2 instead of V1

The below is a snippet that needs to be the first line of a `.ahk` script.

```ahk
#Requires AutoHotkey v2.0
```

## AHK Script at Startup

* Windows Key + R
* shell:startup
* Create Shortcut and Move Shortcut to Startup Folder
