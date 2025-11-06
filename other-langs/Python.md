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

I didn't want the python used in conda to overwrite my basic user-level python, so I created an activation function in one of my dotfiles so I can easily enable conda and use conda's python on command, as opposed to when I login to the shell. Let conda modify your main dotfile, then turn it into a function if my exact dotfile setup is not what is wanted.

https://conda-forge.org/download/ - For install script

`bash Miniforge3-$(uname)-$(uname -m).sh`

`https://github.com/conda-forge`

## Potentially Useful Tools/Alternatives

Some of these I may already have, others may be alternatives to what I'm already using.

* ruff - (linter & formatter)
* ty - (type checker, in preview mode)
  * pylyzer - (type checker, being sunsetted for ty)
* pylance - (type checker, not open source)
* pyright - (type checker, LSP)
* mypy - (static type checker)
* pytest - (testing framework, to address python's built-in module unittest's shortcomings)
* pydantic - (data validation library)
  * https://github.com/pydantic/pydantic
  * https://github.com/Kludex/awesome-pydantic

## Misc Items

`sudo apt-get install python-tk python3-tk`

## Fun Dependencies (From Various Managers: pip, uv, conda-forge, etc)

(May (will) contain duplicate entries, whatever)

May move some of these, or duplicate, to their own respective files since some of these are not python specific.

```sh
# The below was entered after creating a user-level
# virtual env similar to: `conda create -y -n test-env python=3.12`
conda install -y pandas jupyter matplotlib \
  lxml beautifulsoup4 html5lib openpyxl requests \
  sqlalchemy seaborn scipy statsmodels \
  patsy scikit-learn pyarrow pytables numba
```

* Docker - This is more of a system dependency, but this is very useful for setting up python projects.
* pre-commit - Not python specific, manages and maintains multi-language pre-commit hooks.
