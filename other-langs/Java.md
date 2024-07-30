# Java

## Main Install Command

`sudo apt-get install openjdk-21-jdk`

## Undoing Oracle

```sh
# If needed
sudo apt-get uninstall oracle-java11-installer-local
sudo apt-get remove oracle-java11-installer-local
# Set back to auto in each update-alternatives command (Should be latest openjdk
sudo update-alternatives --config java
sudo update-alternatives --config javac
sudo update-alternatives --config javadoc
sudo update-alternatives --config javap
# Check Java home env var
echo $JAVA_HOME
# Set to newly installed path, given by update-alternatives
sudo vim /etc/environment
# E.g. JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"
# May not work:
sudo update-java-alternatives -a
# Remove Oracle drivel
sudo rm /etc/profile.d/jdk.{csh,sh}

# Install Gradle
sudo apt-get install gradle # java
```

## Todo

* Update with more info if needed
