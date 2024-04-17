# Conky

To install:

`sudo apt-get install conky-all`

I can't remember if the directory here, `.cconkyconfig` is needed in the home dir, so if it's not working with just the `.conkyrc` file in this repo's `linux/` dir doesn't do it, then just copy `.cconkyconfig` to the user's home dir.

Be sure to add `Conky-Monitor` to the start-up applications.

## Multiple Monitor Oddity 

If you have more than one monitor, it's possible that conky will not show up on the monitor you want. My fix for it was to just change the monitor it shows up on. Will have to look into a way to duplicate to other monitors as well.

The following was my fix to make it show up on the monitor I consider the main one. I don't know why the OS decided to make the most important monitor a different number than one, it's probably where I have it plugged in on the GPU, but whatever. Something I don't want to think about right now.

* xinerama_head = 2

