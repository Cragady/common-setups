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

OR EVEN BETTER, follow the instructions to extract the appimage, and store that where you want.

I have mine within a dir called `cust-bin`.

```sh
# The you shouldn't have to execute the below command if you've already curled it
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
# ./nvim.appimage

./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version

mv squashfs-root ~/cust-bin
sudo ln -s /home/$USER/cust-bin/squashfs-root/AppRun /usr/bin/nvim
nvim .
```

If you need to uninstall/update it, remove the link, remove the extraction, re-curl it, extract the appimage, and re-link to `/usr/bin/nvim`. A simple `ll` or `ls -la` against `/usr/bin` should tell you what's a link and if your `nvim` is a link. (Hint: It should be if you followed these steps. If you installed it via a package manager, use that to uninstall/update nvim as you see fit)

### WSL Clipboard

* https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows/61864749#61864749
* https://github.com/microsoft/WSL/issues/4440
* https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl

Refer to README.md in this dir for download.

Somewhere in your neovim init files:

`vim.opt.clipboard = "unnamedplus"`

FOR VIM:

```vim
set clipboard=unnamedplus

autocmd TextYankPost * call system('win32yank.exe -i --crlf', @")

function! Paste(mode)
    let @" = system('win32yank.exe -o --lf')
    return a:mode
endfunction

map <expr> p Paste('p')
map <expr> P Paste('P')
```

### If CLI only - fontconfig & unzip

```sh
sudo apt-get install fontconfig -y
sudo apt-get install unzip
```

Create a .fonts dir in your user dir and run the following to load new fonts:

`fc-cache -f -v`

If fonts come in a .zip file:

`unzip Target.zip -d dest_dir`

And then move all fonts to the .fonts dir and re-run the fc-cache command.

### Maybe Missing Essential: FUSE - (AppImage)

If you don't have fuse, you can't use the curl method. So use apt or install fuse. If you're not having issues, then ignore this section.

https://docs.appimage.org/user-guide/troubleshooting/fuse.html#ref-ug-troubleshooting-fuse-fuse3

`sudo apt-get install fuse libfuse2`

After installing run the following commands:

```sh
sudo addgroup fuse
sudo adduser $USER fuse
```

### Maybe Missing Essentials: c, clangd, FUSE(AppImage)

`sudo apt-get install build-essential`

If you plan on having a clang server, you may need the following as well:

`sudo apt-get install clangd --install-suggests`
OR (Likely the correct solution below):

```
sudo apt-get install clangd-12
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
```

This solution started working after a few starts of neovim. I thought I was going to have to look into it a bit more heavily.

If not missing, skip this section.

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

May need to install the `tree-sitter-cli`.

https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md

cargo (rust):

```sh
cargo install tree-sitter-cli
```

npm (node):

```sh
# Missing global flag? Taken from docs.
npm install tree-sitter-cli
```

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

(cli) `wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip -P ~/Downloads`

May need to revisit the deps for this package

