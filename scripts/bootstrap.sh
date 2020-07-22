#!/bin/bash

# update the version of ubuntu deployed
sudo DEBIAN_FRONTEND=noninteractive apt-get update 
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# minecraft disk and some dependencies
sudo mkdir -p /home/minecraft
sudo mkfs.ext4 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/disk/by-id/google-minecraft-disk
sudo mount -o discard,defaults /dev/disk/by-id/google-minecraft-disk /home/minecraft
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y default-jre-headless

# now we can do the craft 
cd /home/minecraft
sudo su
wget https://launcher.mojang.com/v1/objects/a412fd69db1f81db3f511c1463fd304675244077/server.jar

# need to run the jar once for it to create some temp file
java -Xms1G -Xmx3G -d64 -jar server.jar nogui

# go into the eula and accept it
sed -i 's/eula=false/eula=true/g' eula.txt

# we need to use screen to run the jar whilst we are logged out
apt-get install -y screen

# now use screen to start that darn server up
screen -S mcs java -Xms1G -Xmx3G -d64 -jar server.jar nogui
