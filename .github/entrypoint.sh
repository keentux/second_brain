#!/bin/bash

echo "Running script on $1"
ls -la /gh-actions
cp -r /gh-actions ./build && cd build || exit
# Install Flutter
zypper -n install -t pattern devel_basis
zypper -n install cmake ninja clang libicu-devel libgtk-3-0 gtk3-devel glibc libstdc++6 libstdc++-devel\
  coreutils bash curl file git unzip which xz zip pkg-config gzip
echo "Installing Flutter ..."
export FLUTTER_SDK=/usr/local/flutter
git clone -b stable https://github.com/flutter/flutter "${FLUTTER_SDK}"
export PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"
flutter precache
flutter doctor
# Config Flutter
flutter clean
flutter config --enable-linux-desktop
# Build the App
echo "Flutter Preparing build ..."
flutter pub run build_runner build --delete-conflicting-outputs
echo "Build App for Linux ..."
flutter build linux --release -v
if [ -d build/linux/x64/release/bundle/ ]; then
  # Move the build to the shared folder
  [ -d "/gh-actions/build-$1" ] && rm -r "/gh-actions/build-$1"
  mkdir "/gh-actions/build-$1"
  cp -r build/linux/x64/release/bundle/* "/gh-actions/build-$1"
fi