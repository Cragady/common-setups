# Python

Ubuntu comes with python already installed, but an important thing to note: don't mess with the global packages. Always use a virtual env to install packages when needed.

For some reasons, I have the following installed manually:

* python2
* python3-dev
* python3-pip
* python3-venv
* python3-virtualenv

Just install a higher version of python if you don't want to use the system's default version. There may be a python version manager like node's `nvm`, so that may be worth looking into. 

## Python Managers

### PyEnv

https://github.com/pyenv/pyenv

### uv

Python Version Manager and Package/Project manager - written in rust.

https://github.com/astral-sh/uv

```sh
# On macOS and Linux.
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## Conda (conda-forge)

https://conda-forge.org/download/ - For install script

`bash Miniforge3-$(uname)-$(uname -m).sh`

## Misc Items

`sudo apt-get install python-tk python3-tk`
