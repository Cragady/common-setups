#/bin/bash

set -e

# NOTE: DON'T RUN UNLESS YA WANNA
false

exit 1



exit 1

echo 'hi'



# Create subvolume example
sudo btrfs subvolume create /mnt/20tbdest/media

# Verify creation
sudo btrfs subvolume list /mnt/20tbdest

# NOTE:
# copy into it
# fpsync -n 4 \
#   /mnt/source_partition_b \
#   /mnt/20tbdest/media


## NOTE: to save fs UUID info:
## sudo fdisk -l > old-system-fdisk.txt
## sudo lsblk -f > old-system-lsblk.txt
## sudo blkid > old-system-blkid.txt
## Put these alongside the copied files
