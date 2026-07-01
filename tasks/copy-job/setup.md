# Setup

To have a bit better of a time waiting, be sure to use the following flags for the target:

* -o compress=zstd:3,noatime
  * Only for btrfs
* for ext4 exclusively (at least not btrfs)
  * -o noatime

```sh
# For dest btrfs
sudo mount /dev/sdb1 /mnt/20tbdest -o compress=zstd:3,noatime

# For dest ext4
sudo mount /dev/sdb1 /mnt/20tbdest -o noatime
```
