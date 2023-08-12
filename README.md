# Overview

Will be adding items here where necessary. If I'm feeling particularly ambitious, I'll treat this readme like the index for the doucmentation.

This will be a semi-complete instruction set wherever I write items down. When I refer to "you", I'm likely just talking to myself, so don't take offense if I seem a bit abrasive at times.

You should be able to finagle your way to a config that makes sense regardless of the terseness or verbosity of what is written in this repository. This is meant to get a setup quickly, so take what you need, or take all of it. Use a combination of your best judgement and what you want. If something doesn't quite work, it may mean I've done something wrong, or the setup wasn't implemented correctly. In either case, it would be a good exercise to figure out why.

I will be including some setups (maybe) for vs-code. Or rather, I'm debating including the setups for vs-code. I use GitHub to sync my vs-code settings across my OSs. What I really want to do is include some cool remaps I have in my Neovim setup within the vim simulator within vs-code.

So, what I write here for a vs-code setup likely won't be complete, but something that I found interesting that allows me a bit more customization than I realized.

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

I use `Git Lens` in vs-code which is a super easy way to see who committed what, and to diff different points in history without using git commands.

This is what I consider a missing piece, however, I imagine I can either find a Neovim plugin that does this for me, or finagle around with Fugitive to get something similar. I may just resort to utilizing a plugin for this.

## Missing

### Neovim

* Emmet

