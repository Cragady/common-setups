# Overview

## Unity

https://docs.unity3d.com/hub/manual/InstallHub.html#install-hub-linux

* `wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null`
* `sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'`
* sudo apt-get update
* sudo apt-get install unityhub

**Note: For some systems, you may need to ensure the following:

The directory /usr/share/keyrings exists.
The user or group installing the Hub has write permissions to the /usr/share/keyrings directory.
The user or group installing Hub has at least read permissions to the resulting file Unity_Technologies_ApS.gpg.**

### Removal

`sudo apt-get remove unityhub`

## Plastic SCM

https://www.plasticscm.com/plastic-for-linux

* `sudo apt-get update`
* `sudo apt-get install -y apt-transport-https`
* `echo "deb https://www.plasticscm.com/plasticrepo/stable/debian/ ./" | sudo tee /etc/apt/sources.list.d/plasticscm-stable.list`
* `wget https://www.plasticscm.com/plasticrepo/stable/debian/Release.key -O - | sudo apt-key add -`
* `sudo apt-get update`

* `sudo apt-get install plasticscm-cloud`

* `sudo apt-get install plasticscm-complete`

## Other - LSP & Other setup

Use the official `mono` repo

https://www.mono-project.com/download/stable/#download-lin-ubuntu

* `sudo apt-get install ca-certificates gnupg`
* `sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF`
* `echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list`
* `sudo apt-get update`

* `sudo apt-get install mono-devel mono-complete`

https://spaceandtim.es/code/nvim_unity_setup/

omnisharp-roslyn: https://github.com/OmniSharp/omnisharp-roslyn

Clone the repo

Follow the instructions for the install. May need to execute the following command(s):

* `sudo apt-get install dotnet-sdk-8.0`
* `sudo apt-get install dotnet-runtime-8.0`

Then `./build.sh`, and wait for install. If the build tells you that you don't have the correct dotnet version installed, then follow its instructions and modify the `./global.json` config file with the correct version installed. The build should go through, and the build may end on an error. It's likely if you see the messaging `MSBuild server shut down successfully.` before the error, it installed itself fine enough.

https://neovim.discourse.group/t/how-to-setup-omnisharp-on-linux-for-unity-c-with-mono-via-nvim-lspconfig/2928
https://chrislabarge.com/posts/neovim-unity-engine/
