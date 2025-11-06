# Dart

```sh
# TODO: create a function that loads in flutter instead of having the env file add it to path if a separate Dart is wanted from Flutter's Dart.
```

Compiles to ARM, x64, and RISC-V machine code for applications on these architectures.

Compiles to JavaScript & WebAssembly for web apps.

Supports hot reloading.

AOT Compilation and JIT compilation, JIT with Dart VM.

Strongly typed with static code analysis, types can be inferred with keyword `var`.

* `https://dart.dev`
* `https://github.com/dart-lang`

## Installation

`https://dart.dev/get-dart#install-using-the-apt-get-package-manager`

```sh
sudo apt-get update && sudo apt-get install apt-transport-https

wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub \
  | sudo gpg  --dearmor -o /usr/share/keyrings/dart.gpg

echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
  | sudo tee /etc/apt/sources.list.d/dart_stable.list

sudo apt-get update && sudo apt-get install dart

dart --disable-analytics

# To re-enable: `dart --enable-analytics`
```

## Flutter

NOTE: If you install Flutter and don't have dart installed, you can just install Flutter. Flutter includes the Dart SDK.

https://flutter.dev
https://docs.flutter.dev/get-started/manual
https://docs.flutter.dev

### Install

```sh
# sudo apt-get update -y && sudo apt-get upgrade -y # The uzhe
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# Flutter Downloaded and likely in ~/Downloads rn
# tar -xf <sdk_zip_path> -C <destination_directory_path>
tar -xf ~/Downloads/flutter_linux_3.35.7-stable.tar.xz -C ~/program-files
echo 'export PATH="$HOME/program-files/flutter/bin:$PATH"' >> ~/.zshenv # or whatever shell env and corresponding command you want
# Now, either open a new session, or source the env file
flutter --disable-analytics
```

```sh
# Quick Sample of Web App
# Just using mkdir to showcase adding web support to existing project
mkdir test_web_hello && cd test_web_hello
flutter create . --platforms web # Add support to existing project
# OR
flutter create test_web_hello # preferred method
flutter run # -d chrome

# If running an app build, may need libstdc++ installed if it can't find it
sudo apt-get install libstdc++-13-dev # GCC
sudo apt-get install libc++-18-dev # CLANG
sudo apt-get install libstdc++-14-dev # CLANG - because it chose 14 instead of 13.
# NOTE: Also, this fixed my lsp because I never bothered to check which libstdc++ it was trying to use
sudo apt-get install libgtk-3-dev # For app build gui lib
# flutter clean # if necessary
# NOTE: I had to run `flutter clean` for some reason. It was trying to create a dir in /usr/local/ and then copy files to it for whatever reason when trying to run a linux build.
# NOTE: may be good hygiene to run `flutter clean` every once in awhile anyway
# NOTE: a github conversation says that removing the `linux/` sub-dir, then running `flutter create . --platforms=linux # in same project dir or another project dir, if another project dir, copy 'linux/' dir over` is an alternative fix as well.
flutter run # -d linux
```
