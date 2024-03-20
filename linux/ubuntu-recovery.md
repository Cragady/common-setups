# Network Fix

I tried the below, dropping the kernel being used, but what ended up working was just updating apt & apt-get packages on the lower kernel versions, then booting the most recent kernel. Incidentally, I'm using a newer kernel version than the one where the network drivers went kaput due to a newer version being installed.



## Misc - Network Fix

```sh
sudo apt-get install --reinstall linux-image-6.5.0-17-generic
sudo apt-get install --reinstall linux-modules-6.5.0-17-generic
```

