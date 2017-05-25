#!/bin/bash

dpkg --add-architecture i386
apt-get update
apt-get upgrade -y
apt-get install lib32gcc1 libstdc++6 libstdc++6:i386 screen sudo -y


sudo -u p bash << EOF

cd /home/p
mkdir steamcmd
mkdir serverfiles
cd /home/p/steamcmd
wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
tar -xzvf steamcmd_linux.tar.gz
rm steamcmd_linux.tar.gz

./steamcmd.sh +login anonymous +force_install_dir /home/p/serverfiles +app_update 740 validate +quit

cd /home/p
wget https://raw.githubusercontent.com/mog54/csgo-server/master/hlds.sh 
chmod +x hlds.sh
