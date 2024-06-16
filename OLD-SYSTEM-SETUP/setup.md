# NOTES

This is an older file that may include older and ill-advised instructions. Keeping around for reference and legacy's sake.

I have made a few small edits here and there, but it is advisable to look up current install methods for some of the items listed here.


FILE START:




This is a set of notes that was a bit harder to setup on a new install


## Auto-Completion in /etc/inputrc

Add `set completion-ignore-case on`

https://www.howtogeek.com/267061/how-to-ignore-case-when-using-tab-completion-in-the-linux-terminal/

## Use nvm for handling node versions

https://www.sitepoint.com/quick-tip-multiple-versions-node-nvm/

https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04

## Install Gnome Tweak tool

`sudo add-apt-repository universe`
`sudo apt install gnome-tweak-tool`

https://linuxconfig.org/how-to-install-tweak-tool-on-ubuntu-20-04-lts-focal-fossa-linux

## Install dconf-editor

`sudo apt-get install -y dconf-editor`

## Install gnome-shell-extension-dash-to-panel

`sudo apt install gnome-shell-extension-dash-to-panel`

This one requires log out or reboot to activate

https://itectec.com/ubuntu/ubuntu-gnome-3-merge-top-bar-and-ubuntu-dock-side-bottom-bar/

## Increase Number of File Watchers for System

`echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p`

`cat /proc/sys/fs/inotify/max_user_watches`


https://stackoverflow.com/questions/55763428/react-native-error-enospc-system-limit-for-number-of-file-watchers-reached#:~:text=Listen%20uses%20inotify%20by%20default,limit%20is%20set%20to%208192.

## Install Yarn and Add to Path

`curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list`

`sudo apt update && sudo apt install yarn`

For global pathing add the next line to any path files or bash/input files taht are global:

`export PATH="$PATH:`yarn global bin`"`

https://classic.yarnpkg.com/en/docs/install/#debian-stable

https://linuxize.com/post/how-to-install-yarn-on-ubuntu-20-04/

## Install vs code

`sudo snap install --classic code`

Don't do this, just look up the deb package then install with apt.

### Enable glow for vs code

After installing with apt, follow these steps:

* sudo chown -R <user> /usr/share/code/
* Open VS Code
* ctrl + shift + p
* Enable Neon Dreams, or whatever it's called
* Exit code
* sudo chown -R root /usr/share/code/


## Install dotnet

https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#2004-

https://dotnet.microsoft.com/download

## mono & ca-certificates

```bash
sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
```

https://www.mono-project.com/download/stable

## Keepass2

https://linuxhint.com/install_keepass_ubuntu/

This one is weird, can't remember if I added the repository or just installed with apt/apt-get


## If you want emacs

https://linuxhint.com/ubuntu_emacs_installation/


## Java

Note: Use OpenJDK.

`sudo apt update`

This shouldn't show any installed versions
`java -version`

`sudo apt install default-jre`

`java -version`

`sudo apt install default-jdk`

You'll have to manually download then install the version of java that fits your needs.

### If you are on a server push it with `scp`

`scp Downloads/jdk-11.0.7_linux-x64_bin.tar.gz sammy@your_server_ip:~`

### fi

`sudo apt install software-properties-common`

`sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EA8CACC073C3DB2A`

`sudo add-apt-repository ppa:linuxuprising/java`

`sudo apt update`

`sudo mkdir -p /var/cache/oracle-jdk11-installer-local/`

`sudo cp jdk-11.0.7_linux-x64_bin.tar.gz /var/cache/oracle-jdk11-installer-local/`

`sudo apt install oracle-java11-installer-local`

### Managing Java

`sudo update-alternatives --config java`

`sudo update-alternatives --config javac`

`sudo update-alternatives --config java`

`sudo nano /etc/environment`

  * `JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"`

`source /etc/environment`

  * Output: `/usr/lib/jvm/java-11-openjdk-amd64`



https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-20-04
https://www.linode.com/docs/guides/how-to-install-openjdk-ubuntu-22-04/


## R Language

`sudo apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common`

`sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9`

`sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'`

`sudo apt install r-base`

`R --version`

### Compiling R Packages

`sudo apt install build-essential`

`R`

`> sudo apt install build-essential`

`> install.packages("stringr")`

`> library(stringr)`

`> tutorial <- c("How", "to", "Install", "R", "on", "Ubuntu", "20.04")`

`> str_length(tutorial)`

  * Output: `[1] 3 2 7 1 2 6 5`

More R packages: `https://cran.r-project.org/web/packages/available_packages_by_name.html`

  * Install with `install.packages()`

https://linuxize.com/post/how-to-install-r-on-ubuntu-20-04/

## GCC

I think this one comes installed? Here are the steps anyway:

`sudo apt update`
`sudo apt install build-essential`

`sudo apt-get install manpages-dev`

`gcc --version`

### Compile:

`gcc <file name> -o <binary name>`

### Execute:

`./<binary name>`

### Multiplc GCC Versions

`sudo apt install gcc-8 g++-8 gcc-9 g++-9 gcc-10 g++-10`

```bash
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 --slave /usr/bin/g++ g++ /usr/bin/g++-10 --slave /usr/bin/gcov gcov /usr/bin/gcov-10

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8
```

### Update default version

`sudo update-alternatives --config gcc`

## Some Python

#### Python2

`sudo apt install python-pip` (optional)

#### Python3

`sudo apt install python3-venv python3-pip`

`sudo apt-get install python3-dev python3-pip python3-virtualenv`

#### Python Packaging

It is extremely important to install pip/python packages in the user folder or in a virtual environment. Failing to do so may result in odd or broken system behavior.

Virtualenv is recommended to not break differing projects.

If it seems like a good idea, and won't break anything, just be lazy and install in the user's location.

If you installed a package in user, and you need to set up a virtual env, run the same install commands in the virtual env. Even though it will skip installing the packages, it will update the pip freeze command so that you can track the dependencies you need for that project.

##### Notes on User/virtualenv pip Installs:

* Can uninstall pip packages without having to worry if it will delete the same package from the root's installed pip package
  * Needs sudo command to uninstall from root's version. If you like sanity, probably don't do this.

* Create a virtual environment or use the flag `--user` for *all* packages needing install

* virtual env directories can be put inside the root of a project, and ignored with .gitignore

* Can use --target to specify a directory with pip, but can't be targeted with its uninstall command

* ~May need to create aliases for easy access if installed in user's home directory~ Nvm, seems to work without doing that.

##### NOTE

YOU MAY WANT TO INSTALL IN VIRTUALENVS EVEN IF USER'S HOME DIRECTORY IS AN OPTION.

##### Jupyter

* Upgrade pip?
`python -m pip install --user jupyter`

##### Flask

* Upgrade pip?
`python -m pip install --user wheel`
`python -m pip install --user flask gunicorn`

##### Django

Several ways to do this, may need to create an alias for this as it's not in path (this is a good thing), this is the method I apparently used:

`python -m pip install --user Django`

### Python Alternatives

Since python is easy enough to install, these are the steps to add default for python and to be able to switch

`ls /usr/bin/python*`
  * Out: `/usr/bin/python2  /usr/bin/python2.7  /usr/bin/python3  /usr/bin/python3.7  /usr/bin/python3.7m  /usr/bin/python3.8  /usr/bin/python3-futurize  /usr/bin/python3m  /usr/bin/python3-pasteurize` Or similar

`sudo update-alternatives --list python`
  * Out if none: `update-alternatives: error: no alternatives for python`

`sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1`

`sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2`

`sudo update-alternatives --list python`

Now you'll be able to switch defaults with `sudo update-alternatives --config python`


### Apache 2

```bash
sudo apt update && sudo apt install apache2
sudo ufw app list
sudo ufw allow 'Apache'
sudo ufw status
sudo systemctl status apache2
hostname -I
curl -4 icanhazip.com
```

In address bar go to `http://your_server_ip`

https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-20-04

## Nginx

```bash
sudo apt update && sudo apt install nginx
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status
```


## Openssh

```bash
sudo apt update && sudo install -y openssh-server
sudo systemctl status ssh
```

Configure ufw to what you want to allow access

## Vim

```bash
sudo apt-get update
sudo apt-get install vim
sudo apt-get install vim-gtk3 -y
```

## Conky

`sudo apt-get install conky-all`
`conky`

### Optional

```bash
sudo add-apt-repository ppa:mark-pcnetspec/conky-manager-pm9
sudo apt-get install conky-manager
```

## neovim

```bash
sudo apt-get install neovim
sudo apt-get install python3-neovim
```

## Plugin manager - vim/neovim

```bash - for vim
 curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
``` 

```bash - for Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

https://github.com/junegunn/vim-plug

## php and friends

```bash
sudo apt install php libapache2-mod-php php-mysql

php -v
```

For a full setup for production environment:

https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-20-04

## PostgreSQL

```bash
sudo apt update

sudo apt install postgresql postgresql-contrib

sudo -i -u postgres

psql
```

`\q` exist postgres

`sudo -u postgres psql

### Creating New Role

Log in to postgres account

`createuser --interactive`

Or use sudo without switching form normal account:

`sudo -u postgres createuser --interactive`

### Creating New Database

`createdb <db name>`

OR 

`sudo -u postgres createdb <db name>`

Be sure to create db for user.

### Add linux non-matching user

`sudo adduser <user name>`

Connect to database:

```bash
sudo -i -u <user>
psql
```

Or Inline

```bash
sudo -u sammy psql
```

If you want to connect to different db, specify the db:

`psql -d <db name>`

Once logged in, check connection info:

`\conninfo`

## MongoDB

```bash
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -

# If gnupg isn't installed
sudo apt-get install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -

```



```bash
# Create file list

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# Reload local package database
sudo apt-get update

# Install MongoDB packages
# Latest stable version
sudo apt-get install -y mongodb-org

# If unsure on which init system, use this:
ps --no-headers -o comm 1

# Start MongoDB
sudo systemctl start mongod
```

## On Swap files

https://itsfoss.com/create-swap-file-linux/

## Extra Vim Settings

- In /etc/vim/vimrc

```bash
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

:set laststatus=2
:set statusline=%f%m%r%h%w\ [%Y]\ [0x%02.2B]%<\ %F%=%4v,%4l\ %3p%%\ of\ %L

:set tabstop=4
:set shiftwidth=4
:set expandtab
```

## Openvpn

```bash
sudo apt update && sudo apt install openvpn easy-rsa
```

https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-an-openvpn-server-on-ubuntu-20-04

## Docker 

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update && sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

# x86_64 / amd64

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo docker run hello-world

sudo usermod -aG docker your-user
```

## Suspension

```bash
sudo apt install pm-utils hibernate

cat /sys/power/state # >freeze mem disk

grep swap /etc/fstab

# Copy UUID

sudo vim /etc/default/grub

# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=UUID=YOUR_VALUE"

sudo update-grub

sudo systemctl hibernate
```

Might need to add a partition on a separate disk to have this work in the most efficient way without destroying the main ssd

## ClamAV

Malware scanner

```bash
sudo apt-get install clamav

sudo freshclam # Updates Database

# If err, then run this:

sudo /etc/init.d/clamav-freshclam stop
sudo freshclam

# Restart

sudo /etc/init.d/clamav-freshclam start

man clamav

clamscan -i -r ~/


clamscan --remove=yes -i -r ~/
```

# Gimp

```bash
sudo apt-get update
sudo apt-get install gimp
```

# Redis

Redis pulled a switcharoo. Look for a fork, like [valkey](https://github.com/valkey-io/valkey).

```bash
# sudo add-apt-repository ppa:redislabs/redis
# sudo apt-get update
# sudo apt-get install redis
```

# nvm

``` bash
# Look up current version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash

# Reload .bashrc so nvm command works

source ~/.bashrc

# Explicitly install and use supported node version
nvm install 12 # Or 20, or lts

nvm use 12 
```

# Color Picker

```sh
sudo apt-get install gpick

```

