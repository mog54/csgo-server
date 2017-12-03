#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get install libxml-parser-perl libpath-class-perl perl-modules screen rsync sudo e2fsprogs unzip subversion pure-ftpd libarchive-zip-perl libc6 libgcc1 git curl -y
apt-get install libc6-i386 lib32gcc1 -y
apt-get install libhttp-daemon-perl -y
apt-get install libarchive-extract-perl -y
adduser ogpbot
usermod -a -G sudo ogpbot

sudo -u ogpbot bash << EOF

cd /home/ogpbot/
wget https://github.com/OpenGamePanel/OGP-Agent-Linux/archive/master.zip
unzip master.zip
cd OGP-Agent-Linux-master/

su - ogpbot

echo "sudo bash ./install.sh"
