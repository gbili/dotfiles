#!/bin/sh

[ $# -eq 0 ] && { echo "Usage: $0 -t  \nExample:\n$0 -t zivili.ch/gbili/node-cron:0.0.1"; exit 1; }

while getopts t: flag
do
    case "${flag}" in
        t) tag=${OPTARG};;
    esac
done

sudo docker build -t $tag .;
sudo docker push $tag;
