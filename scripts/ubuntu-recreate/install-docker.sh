#!/bin/sh

echo -e "First step is to install gbili/dotfiles, have you done it? \n\n\n\n\n"

echo -e " ###### Welcome to Ubuntu server initial installs recreation \n"

echo -e " ###### Step: 0 - Install Docker \n"

sudo apt-get remove docker docker-engine docker.io containerd runc

echo -e " ###### Update the apt package index and install packages to allow apt to use a repository over HTTPS \n"
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo -e " ###### Adding Docker GPG Key \n"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo -e " ###### Please verify that you see this: 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88 \n"

sudo apt-key fingerprint 0EBFCD88

echo -e " ###### set up the stable repository \n"

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo -e " ###### Installing Docker Engine \n"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

echo -e " ###### Verifying that Docker Engine is installed properly, doing 'Hello world' \n"

sudo docker run hello-world

echo -e " ######  ###### Installing Docker-compose now, will get the latest stable release \n \n"

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo -e " ###### Appling executable permission to binary \n"

sudo chmod +x /usr/local/bin/docker-compose

echo -e " ###### Checking the version of Docker Compose \n"

docker-compose --version

echo -e " ###### Step 0 is now finished, hopefully successfully, you now need to setup 'dotfiles' \n"


