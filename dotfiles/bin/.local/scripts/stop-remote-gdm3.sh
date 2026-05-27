#!/bin/bash

sudo systemctl stop gdm3

sudo mv /etc/gdm3/custom.conf.bak /etc/gdm3/custom.conf
