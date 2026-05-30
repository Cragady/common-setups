#!/bin/bash

loginctl disable-linger "$USER"

systemctl --user stop remote-plasma-gui.target
