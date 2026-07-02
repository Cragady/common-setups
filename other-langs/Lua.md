# Lua

## Versions

A specific neovim plugin needs `luarocks`. Install this by using the following:

```sh
sudo apt-get luarocks

# May want luajit? Or not?
sudo apt install luajit
```

### 5.1 (Neovim Default)

```sh
sudo apt install lua5.1 liblua5.1-0-dev
```

### 5.4

`sudo apt-get install lua5.4 liblua5.4-dev`

### 5.3

`sudo apt-get install lua5.3 liblua5.3-dev`

### 5.2

`sudo apt-get install lua5.2 liblua5.2-dev`

## Configuration

```sh
sudo update-alternatives --config lua-compiler
sudo update-alternatives --config lua-interpreter
```
