#!/bin/bash

# NOTE: make sure correct drive is tested
# lsblk

sudo smartctl -H /dev/sdb
sudo smartctl -a /dev/sdb
sudo smartctl -i /dev/sdb
sudo smartctl -c /dev/sdb
# # Short test: # sudo smartctl -t short /dev/sdb
echo "$((1639 / 60))"
echo 'Be sure to do this may take around 27 hours: `sudo smartctl -t long /dev/sdb`'
echo 'Also, make it a service. Much like the copy job.'


# NOTE:
# To view in-progress or results of a running test:
# sudo smartctl -l selftest /dev/sdb

