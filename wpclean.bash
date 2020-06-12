#!/bin/bash
[ $# -eq 0 ] && { echo "Usage: $0 -r <reverse_domain>"; exit 1; }

# get the parameter -d's value
while getopts r: flag
do
    case "${flag}" in
        r) reversedomain=${OPTARG};;
    esac
done

if [ -z "$reversedomain" ]; then
    echo "missing parameter -r <reverse_domain>";
    exit -1;
fi

sitesdir="/home/ubuntu/Documents/workspace/sites"
domaindir="$sitesdir/$reversedomain"

# cd to dir and create if not exists

if [ ! -d "$domaindir" ]; then
    echo "Directory $domaindir DOES NOT exists.";
    echo "Exit";
    exit -1;
fi

cd $domaindir;

# clean site dir
docker-compose down
sudo rm -fR wordpress_files
sudo rm -fR db_data
rm docker-compose.yml
