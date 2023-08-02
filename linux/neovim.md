# Neovim

This setup follows this video: https://www.youtube.com/watch?v=w7i4amO_zaE&ab_channel=ThePrimeagen

Repo: https://github.com/ThePrimeagen/init.lua

Some of the key remappings don't work, and this is likely due to me diverging slightly from how ThePrimeagen sets his env up.

Some other things may also be whack. I may or may not fix this later with a different setup/config.

## Installs

If on Debian, or a Debian based distro you can use `sudo apt-get install neovim`, but the repo does not have latest stable. 

```sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
```

If you use the shell script, add an alias to whatever rc/profile file is necessary.

### ripgrep

This is required for the "<leader>ps" keybinding (grep files easily)

https://github.com/BurntSushi/ripgrep#installation

Ubuntu/Debian

```sh
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
```

### tmux

Required for the <C-f> keybinding

`sudo apt-get install tmux`

## Package Manager (May change later)

https://github.com/wbthomason/packer.nvim

Script:

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

<!-- create pathing if not exist-->
`nvim ~/.config/nvim/lua/cragady/packer.lua`

Basic file:

```lua
-- ~/.config/nvim/lua/cragady/packer.lua
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
end)

```

Write file, then `:so` and `:PackerSync`

## Fuzzy Finder

https://github.com/nvim-telescope/telescope.nvim

Snippet will already be in file

```lua
-- ~/.config/nvim/lua/cragady/packer.lua
-- in require func
use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
}
```

`:so`
`:PackerSync`

## Color Scheme - May Change Quickly 

https://github.com/rose-pine/neovim

## Treesitter

https://github.com/nvim-treesitter/nvim-treesitter

## Harpoon

https://github.com/ThePrimeagen/harpoon

## Undotree

https://github.com/mbbill/undotree

## vim-fugitive

https://github.com/tpope/vim-fugitive

## LSP

Prime's vid is using the red in [this link](https://github.com/VonHeikemen/lsp-zero.nvim/commit/e7695ff341ed2144dcda9a85d8cbeaa7bc921d4e). If the LSP is feeling like it's lacking, then look into this a bit more.

## TODO Tree

<!-- TODO: test -->

Todos won't be highlighted in the MD file (at least not with my setup), but it will show up if you use the command `:TodoQuickFix`

https://github.com/folke/todo-comments.nvim

Install Requirements and download + install wanted font.

https://www.nerdfonts.com/font-downloads - Hack Nerd Font

May need to revisit the deps for this package

