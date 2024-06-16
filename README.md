# Overview

Before everything: type `/TSUpdate<CR>`

This repo assumes a setup on debian-like systems. This setup will likely be applicable to other distros, but if not, there's probably alternatives to the solutions in place.

The root directory will give a setup for linux, more specifically the `Ubutnu` "distro" that uses linux as its kernel. There may be a couple of extra directories in this repo for other OS's/distros e.g. `windows`, `mac`, etc. Everything under this directory can be assumed to be applicable to `Ubuntu`, or `Debian` (mostly Ubuntu). If it doesn't look like it belongs to another OS, it likely doesn't. And even if it looks like it could belong to another OS, context will give way to clarity. If that doesn't, as long as it works... well, it works.


## Main Notes About This Readme

This is not meant to cover all cases and problems you, (me, I, myself), will come across. This is meant to provide a generalized instruction set that you can follow that will get you anywhere between 90-100% of the way there. Hopefully things won't change in a way that will cause lots of issues. You've got this, you can figure out any whackyness that you can come across. If you can do that, I can provide some hopefully somewhat clear instructions.

Will be adding items here where necessary. If I'm feeling particularly ambitious, I'll treat this readme like the index for the doucmentation.

This will be a semi-complete instruction set wherever I write items down. When I refer to "you", I'm likely just talking to myself, so don't take offense if I seem a bit abrasive at times.

You should be able to finagle your way to a config that makes sense regardless of the terseness or verbosity of what is written in this repository. This is meant to get a setup quickly, so take what you need, or take all of it. Use a combination of your best judgement and what you want. If something doesn't quite work, it may mean I've done something wrong, or the setup wasn't implemented correctly. In either case, it would be a good exercise to figure out why.

I will be including some setups (maybe) for vs-code. Or rather, I'm debating including the setups for vs-code. I use GitHub to sync my vs-code settings across my OSs. What I really want to do is include some cool remaps I have in my Neovim setup within the vim simulator within vs-code.

So, what I write here for a vs-code setup likely won't be complete, but something that I found interesting that allows me a bit more customization than I realized.

Maybe I'll just download the Windows version of Neovim and use the vs-code plugin for Neovim and do a basic config for that.

## Very Important Tree-Sitter thing

Run `:TSUpdate` every now and then if tree sitter is giving you issues.

## Neovim + Fugitive

To run Fugitive within Neovim, use this command: `:Git`

I would recommend exploring the 'Fugitive' plugin for Neovim. At first I was a bit foolhardy about only using the shell's CLI for interfacing with git, but I took a few moments to play around with it. Highly recommend.

There are a couple of things that makes me a little bit hesitant about a complete switch from vs-code. A couple of these items include git related items, but so far as I can currently tell, Fugitive may address a portion of this.

The diff tool is amazing, I use these commands:

* `dv` - splits & diffs vertically
* `dq` - quits the diffs (I think this needs to happen in the main window of Fugitive)

Other useful commands:

* `<C-w>v` - splits a new buffer vertically (Not fugitive specific)
* `<C-w><C-w>` - Moves focus to the next split buffer (Not Fugitive specific, there are other buffer movement commands that I need to become familiar with)

Every now and then, I screw up the split buffers and have to drop out of nvim and start it again. Less than ideal, but I imagine through time this will not be an issue.

I use `Git Lens` in vs-code which is a super easy way to see who committed what, and to diff different points in history without using git commands yourself.

This is what I consider a missing piece, however, I imagine I can either find a Neovim plugin that does this for me, or finagle around with Fugitive to get something similar. I may just resort to utilizing a plugin for this.

I haven't experimented with Fugitive's merge conflict tool at all. I'm hoping that it has color highlighting, and a view that is similar to vs-code's. I did dip into Fugitive's docs and it says that when there's a conflict, it has a three-way view. This isn't something I'm a huge fan of. Maybe I ought to learn it, or maybe it's not that big of a deal. I like the single file conflict tool w/highlighting that vs-code provides. If I can get something similar to that along with some nice commands to handle multiple conflicts at a time, this may be another concern that is a non-issue. Or, I just learn the conflict tool that Fugitive provides and maybe come to (hopefully) realize I like that better instead. 

I realize some of my concerns may just come down to a skill-issue, and I do plan on rectifying that as much as I can. When I'm developing for my employer, the name of the game is productivity, and often that means the path of least resistance. Unfortunately that means vs-code for now (most the time). This means I have to rectify skill-issues in my free time and when I have the energy for it. That being said, as long as I work towards closing that gap, I may find myself more proficient in Neovim eventually, and have another editor I can fly through under my belt.

I will most likely use Fugitive, possibly use other plugins, _and_ drop back down to the shell to handle git operations.

## VS-Code and Other Editors/IDEs

I realize this comes down to more skill & knowledge issues, however the vastness of these issues may make it more prudent to use something other than Neovim.

Currently, for me at least, it makes more sense to handle game development with my current vs-code setup. I get autocompletion and syntax checking/highlighting (along with a super easy way to see & handle this) not only for the language itself, but for the extra Classes, Properties, Methods, etc. coming in from the game engine as well. This, to me, makes it feel like I would have to create my own plugins to handle this. Perhaps I will. Perhaps this won't be necessary. Skill and knowledge issue. I feel like it would be cool if I just found a way to do all of this.

I did learn something about my fight with VS-Code and getting it to work with the language and game engine I was using: I gave up a lot of productivity just to have the setup I wanted.

I refused to use the right tool for the right job, but in the end, I made it the right tool. So a setup where I can get the expected functionality from Neovim + a game engine (and maybe some languages that the LSP has a harder time with (Yeah, skill-issue)) is cool and desired, but it's not optimal for productivity starting out with. It's something I'll have to figure out during a time where productivity isn't as important (it's always important, but sometimes you can get away with tinkering around because other things are happening).

## Emacs + Other Notes

Lol.

(I'll likely poke around with it here and there. I won't be hard-core learning it unless I'm feeling particularly ambitious.)

You won't have to pay too much attention to my Emacs setup. It's just a basic no-config install. It seems like there are as many pre-baked configs + extensions to Emacs as there are Linux distros. For Emacs, it may make a lot more sense just to learn the basics of it, and then configure and personlize it to how you see fit. If you blindly just copy someone else's config + setup for it, you may miss out on what exactly is being changed to achieve the functionality it has and why. If you're in a situation where you need to use a base Emacs install, you may have a harder time finding your way around what you want to do.

Granted, you don't have to follow that thought process to a T. I certainly don't (Neovim), but I will say this:

I learned some basics on vi before I came across vim, and found vim to be much better. It wasn't even a question. I became maybe a novice in vim before I heard of Neovim. It was a back and forth between vim and Neovim for a time, and during that time I picked up quite a few tricks to become an even better novice. I was hesitant to make the swap because I had a weird purist-like mindset. I kept that mindset too long, and I broke it by seeing what I do with my Linux distros. As soon as I get a distro, I config it quite heavily (or until I'm sick of configuring it and decide to config it in small chunks later). I figured if that's what I do w/Linux, this is what people have done with Neovim vs Vim. And even further than that, this is what people have done with base Neovim vs Neovim that's been configged.

So I ended up copying a config for Neovim and then built out slightly from there. Even though I only consider myself and adept-novice, I have an understanding on why things are configured, and how to configure them myself. I still know how to do what I want to do in vi, and I know how to configure Neovim if I was just given a base install.

## Nano

An esoteric editor says "what"?

### How to use

* `sudo apt-get update && sudo apt-get install vim -y`

(Honestly, if it makes you happy, use it. You'll get no configs from me though.)

It's pretty simple to use, but I don't know how to configure it (probably not that hard to figure out). I just personally don't know why you would use this when other editors exist.

## Missing

### M - Neovim

* Emmet (Not missing)
* Git Lens / Git Blame (Maybe)
  * Not really missing, just use `:Git blame`, or `:Git`, or `:Git <sub command>`

