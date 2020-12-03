#!/bin/sh

echo -e " ###### We now need to setup Nginx Let's Encrypt Proxy \n"

echo -e " ###### Launching Docker-compose nginx-proxy \n"

cd ~/dotfiles/scripts/ubuntu-recreate/nginx-proxy;

docker network create nginx-proxy

docker-compose up -d

cd
