#!/bin/bash

# NOTE: verify copy job
# We expect no output here, but it can show things like:
# games/foo/bar.txt
# games/baz/save.dat
# If this is the case, we just remove `--dry-run`
rsync \
  -aHAX \
  --numeric-ids \
  --delete \
  --dry-run \
  /mnt/8tbsrc/ \
  /mnt/20tbdest/



#### NOTE: To get missed files:
#### sudo rsync \
####   -aHAX \
####   --numeric-ids \
####   --delete \
####   /mnt/8tbsrc/ \
####   /mnt/20tbdest/



#### NOTE: Suuuper in-depth check
#### (May want to turn into service, hours on each side.)
#### Each file needs to be read and hashed
#### sudo rsync \
####   -aHAX \
####   --numeric-ids \
####   --delete \
####   --dry-run \
####   --checksum \
####   /mnt/8tbsrc/ \
####   /mnt/20tbdest/
