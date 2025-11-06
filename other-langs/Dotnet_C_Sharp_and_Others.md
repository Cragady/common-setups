# Dotnet, C#, VB, Oh My! What the F#?!

https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?tabs=dotnet9&pivots=os-linux-ubuntu-2404

May change. Just go to current install instructions on Microsoft's website.

## Install

```sh
sudo add-apt-repository ppa:dotnet/backports # For Ubuntu 24.04 & .NET 9

sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-9.0

sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-9.0

sudo apt-get install -y dotnet-runtime-9.0
```
