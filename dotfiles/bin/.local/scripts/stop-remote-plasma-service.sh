#!/bin/bash

loginctl disable-linger "$USER"
systemctl --user stop rustdesk.service
systemctl --user stop remote-plasma.service
systemctl --user stop xorg.service
