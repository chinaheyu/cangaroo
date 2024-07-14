#!/bin/bash

set -e

apt-get update -y
apt-get install -y pkg-config build-essential git qt5-qmake qtbase5-dev libnl-3-dev libnl-route-3-dev cmake qt5-default libqt5serialport5 libqt5serialport5-dev libqt5charts5 libqt5charts5-dev
qmake -qt=qt5
make
make install

cd tools
chmod +x linuxdeployqt-continuous-x86_64.AppImage
./linuxdeployqt-continuous-x86_64.AppImage --appimage-extract
linuxdeployqt=$PWD/squashfs-root/AppRun
cd ..

mkdir -p /tmp/deploy/AppDir/usr/bin
mkdir -p /tmp/deploy/AppDir/usr/share/applications
mkdir -p /tmp/deploy/AppDir/usr/share/icons
cp bin/cangaroo /tmp/deploy/AppDir/usr/bin
cp cangaroo.desktop /tmp/deploy/AppDir/usr/share/applications
cp src/assets/cangaroo.svg /tmp/deploy/AppDir/usr/share/icons
pushd /tmp/deploy
$linuxdeployqt AppDir/usr/share/applications/cangaroo.desktop -appimage -no-translations
popd
cp /tmp/deploy/cangaroo-x86_64.AppImage bin
rm -rf /tmp/deploy
