#!/bin/bash
[ $# -eq 0 ] && { echo -e "Usage: $0 -r <reverse_domain> -s <dockerfile_sites_dir>"; exit 1; }

# get the parameter -d's value
while getopts r:s: flag
do
    case "${flag}" in
        r) reversedomain=${OPTARG};;
        s) sitesdir=${OPTARG};;
    esac
done

if [ -z "$reversedomain" ]; then
    echo -e "missing parameter -r <reverse_domain>";
    exit -1;
fi

if [ -z "$sitesdir" ]; then
    sitesdir="$HOME/Documents/workspace/wordpress_sites"
    echo -e "No wordpress sites dir specified with option -s, using default";
    echo -e "$sitesdir";
fi

domaindir="$sitesdir/$reversedomain"

# cd to dir and create if not exists

if [ ! -d "$domaindir" ]; then
    echo -e "Directory $domaindir DOES NOT exists.";
    echo -e "Exit";
    exit -1;
fi

cd $domaindir;

# clean site dir
docker-compose down
sudo rm -fR wordpress_files
sudo rm -fR db_data
rm docker-compose.yml
