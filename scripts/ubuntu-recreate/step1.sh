#!/bin/sh

echo " ###### We now need to setup Nginx Let's Encrypt Proxy \n"

echo " ###### Launching Docker-compose nginx-proxy \n"

cd ~/dotfiles/scripts/ubuntu-recreate/nginx-proxy;

docker-compose up -d
