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

## Useful Tools

https://learn.microsoft.com/en-us/aspnet/core/blazor/webassembly-build-tools-and-aot?view=aspnetcore-10.0

```bash
dotnet workload install wasm-tools
# To check other workload installs
dotnet workload list
```
