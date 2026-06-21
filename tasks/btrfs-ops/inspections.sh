#!/bin/bash

sudo btrfs subvolume show /mnt/20tbdest


sudo btrfs inspect-internal rootid /mnt/20tbdest
