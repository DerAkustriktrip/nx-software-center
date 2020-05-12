#!/bin/bash

apt -yy -qq update
apt -yy -qq install wget gnupg2

### Add KDENeon Repository
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 55751E5D 1B69B2DA > /dev/null
wget -qO /etc/apt/sources.list.d/neon-user-repo.list https://raw.githubusercontent.com/Nitrux/nitrux-iso-tool/development/configs/files/sources.list.neon.user
wget -qO /etc/apt/sources.list.d/nitrux-repo-.list https://raw.githubusercontent.com/Nitrux/nitrux-iso-tool/development/configs/files/sources.list.nitrux
apt -yy -qq update

### Install Dependencies
apt -yy -qq install cmake extra-cmake-modules qtbase5-dev git qtdeclarative5-dev libqt5xmlpatterns5-dev autotools-dev automake libtool libgtk2.0-dev libfuse-dev libappimage-dev patchelf xxd desktop-file-utils 

## Build
mkdir build && cd build
cmake .. -DCMAKE_BUILD_PREFIX=Release -DCMAKE_INSTALL_PREFIX=/usr
make
