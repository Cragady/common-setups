# Overview

DO NOT REPLACE THE ENTIRE `.config` DIR UNLESS YOU'RE TRACKING _ALL_ OF YOUR CURRENT CONFIGS WITHIN IT

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

