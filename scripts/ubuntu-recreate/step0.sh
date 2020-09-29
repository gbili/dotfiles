#!/bin/sh
echo "First step is to install gbili/dotfiles, have you done it?"

echo "Welcome to Ubuntu server initial installs recreation"

echo "Step: 0 - Install Docker"

sudo apt-get remove docker docker-engine docker.io containerd runc

echo "Update the apt package index and install packages to allow apt to use a repository over HTTPS"
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo "Adding Docker GPG Key"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Please verify that you see this: 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88"

sudo apt-key fingerprint 0EBFCD88

echo "set up the stable repository"

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo "Installing Docker Engine"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

echo "Verifying that Docker Engine is installed properly, doing 'Hello world'"

sudo docker run hello-world

echo "Installing Docker-compose now, will get the latest stable release"

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo "Appling executable permission to binary"

sudo chmod +x /usr/local/bin/docker-compose

echo "Checking the version of Docker Compose"

docker-compose --version

echo "Step 0 is now finished, hopefully successfully, you now need to setup 'dotfiles'"

echo "We now need to setup Nginx Let's Encrypt Proxy"