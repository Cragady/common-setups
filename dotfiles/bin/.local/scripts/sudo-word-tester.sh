#!/bin/bash

echo 'This script will have different outputs if ran with sudo before the first sudo call in this script.'
echo 'Other commands will likely look the same due to flags being passed to sudo.'

echo 'exec: sudo echo $HOME'
sudo echo $HOME

echo 'exec: sudo -s echo $HOME'
sudo -s echo $HOME

echo 'exec: sudo echo ~'
sudo echo ~


echo 'exec: echo $SHELL'
echo $SHELL

# -s = shell
echo 'exec: sudo echo $SHELL'
sudo echo $SHELL

