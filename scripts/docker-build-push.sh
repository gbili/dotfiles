#!/bin/sh

PRIV_REG_HOST=$(${HOME}/dotfiles/scripts/private-registry-host.sh);
[ $# -eq 0 ] && { echo -e "Usage: $0 -t  \nExample:\n$0 -t ${PRIV_REG_HOST}/gbili/node-cron:0.0.1"; exit 1; }

while getopts t: flag
do
    case "${flag}" in
        t) tag=${OPTARG};;
    esac
done

sudo docker build -t $tag $PWD;
sudo docker push $tag;
