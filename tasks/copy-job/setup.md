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

## Potential Change

It may do well to combine the copy-job and the verify script in one job, which is p much shown in the following:

```sh
fpsync ...
fpsync_status=$?

if rsync -aHAX --numeric-ids --delete --dry-run /home/user/ /mnt/dest/ | grep -q .; then
    echo "Verification failed: destination differs from source."
    exit 1
fi

if [ "$fpsync_status" -ne 0 ]; then
    echo "fpsync exited with $fpsync_status, but verification passed."
fi

exit 0
```
