# Overview

DO NOT REPLACE THE ENTIRE `.config` DIR UNLESS YOU'RE TRACKING _ALL_ OF YOUR CURRENT CONFIGS WITHIN IT

There are probably going to be some missing configs due to certain installs I've forgotton about. If you don't want zsh, and want to use bash, there's something odd going on with the bash completion. I'm unsure if it came with a good completion, or if I customized it. I don't want to chase that down right now, so if you want to use bash, and you're not getting the completion experience you're wanting, then config it, or set something else up. I may do this later? Or I may not. I may not have done anything with this.

## General Setups

Install nvm (Node Version Manager). https://github.com/nvm-sh/nvm

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
```

Install Zsh, ezpz.

Install oh-my-zsh, and any pre-reqs that are needed: https://github.com/ohmyzsh/ohmyzsh

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install p10k, and any pre-reqs that are needed: https://github.com/romkatv/powerlevel10k

```sh
# If you installed oh my zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

You'll also have to set `ZSH_THEME="powerlevel10k/powerlevel10k"` within `.zshrc`, this setting should be close to the top. May not have to do this if you copied the .zshrc before this point.

Copy configs from this repo to your home dir, in a way that is similar to pathing where items exist. Extra credit if you want to diff these files with the auto-generated files.

(May not need .p10k.zsh - I didn't modify this much at all. Including just in case.)

`sudo chsh -s /bin/zsh`
OR
`chsh -s /bin/zsh`

(Or let it do it for you)

If you want p10k fonts (and are cli-only), `wget` these into `~/Downloads`, and load the fonts:

* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
* https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

Font handling mentioned in the neovim.md. After fonts are installed, it's probably better to let p10k handle setting the font config.

I'll have to revisit fonts some-time due not setting the fonts up correctly w/wsl

If you have a gui, just click on the files, and select `Install` on the popup. If you're on Ubuntu, and you click `install` on any italic versions of the fonts and it still says `install`, do not keep clicking it. It has already installed. May be a bug.

If you keep clicking it, it will keep installing.

### WSL Clipboard

```sh
# if ~/bin doesn't exist
mkdir ~/bin
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe ~/bin/
sudo ln -s ~/bin/win32yank.exe /usr/local/bin/win32yank.exe
```

You can also skip the local user bin dir if you want and just move `win32yank.exe` directly to `/usr/local/bin/win32yank.exe`. Up to you.

### Windows Terminal/WSL

You'll likely want to remove the `<C-c>` and `<C-v>` keybindings for copy/paste respectively. You should have `<C-C>`, and `<C-V>` for these commands. If you don't, it would probably be convenient to add them.

## Notes

If the setup is slightly off, I may need to re-order some steps, or re-do some steps after certain commands are ran. I just kinda poked things until it worked, so that may need to happen again. I'll attempt to be disciplined about keeping this document updated in such a case.

I'll be leaving out other config files for now, I don't think they're necessary? If they are, I'll be updating this repo.

My setup will likely need an overhaul at some point so I can leave all auto-generated files alone, or have minimal modifications to them.

One example for this would be creating an alias file and sourcing that in any bash/zsh config files.

## Git Config

Do something like this maybe I guess?

.gitconfig

```
[user]
	email = *****
	name = Cragady
[credential]
	modalPrompt = false
[filesystem "Oracle Corporation|11.0.9|/dev/sda2"]
	timestampResolution = 6000 nanoseconds
	minRacyThreshold = 7564 microseconds
[diff]
	tool = vimdiff3
	guitool = gvimdiff3
```

Most of this should be already done for you, but the `[diff]` entry may need work. May also want to change editors too. I forget what the default is, but if it isn't vim or neovim, it's definitely worth changing.

You probably don't need to edit the `.gitconfig` file directly:

```sh
git config --global diff.guitool gvimdiff3
git config --global diff.tool vimdiff3
```

Not too sure why [filesystem] is included. I'll have to figure that out later.

