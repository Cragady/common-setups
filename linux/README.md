# Overview

DO NOT REPLACE THE ENTIRE `.config` DIR UNLESS YOU'RE TRACKING _ALL_ OF YOUR CURRENT CONFIGS WITHIN IT

## General Setups

Install nvm (Node Version Manager). https://github.com/nvm-sh/nvm

Install Zsh, ezpz.

Install oh-my-zsh, and any pre-reqs that are needed: https://github.com/ohmyzsh/ohmyzsh

Install p10k, and any pre-reqs that are needed: https://github.com/romkatv/powerlevel10k

Copy configs from this repo to your home dir, in a way that is similar to pathing where items exist. Extra credit if you want to diff these files with the auto-generated files.

(May not need .p10k.zsh - I didn't modify this much at all. Including just in case.)

`sudo chsh -s /bin/zsh`
OR
`chsh -s /bin/zsh`

## Notes

If the setup is slightly off, I may need to re-order some steps, or re-do some steps after certain commands are ran. I just kinda poked things until it worked, so that may need to happen again. I'll attempt to be disciplined about keeping this document updated in such a case.

I'll be leaving out other config files for now, I don't think they're necessary? If they are, I'll be updating this repo.

My setup will likely need an overhaul at some point so I can leave all auto-generated files alone, or have minimal modifications to them.

One example for this would be creating an alias file and sourcing that in any bash/zsh config files.

