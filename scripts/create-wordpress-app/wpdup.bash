#!/bin/bash
[ $# -eq 0 ] && { echo "Usage: $0 -r <reverse_domain> -s <dockerfile_sites_dir>"; exit 1; }

# get the parameter -d's value
while getopts r:s: flag
do
    case "${flag}" in
        r) reversedomain=${OPTARG};;
        s) sitesdir=${OPTARG};;
    esac
done

if [ -z "$reversedomain" ]; then
    echo "missing parameter -r <reverse_domain>";
    exit -1;
fi

if [ -z "$sitesdir" ]; then
    sitesdir="$HOME/Documents/workspace/sites"
    echo "No sites dir specified with option -s, using default";
    echo "$sitesdir";
fi

domaindir="$sitesdir/$reversedomain"

# cd to dir and create if not exists

if [ ! -d "$domaindir" ]; then
    echo "Directory $domaindir DOES NOT exists.";
    echo "Exit";
    exit -1;
fi

cd $domaindir;

# clean wordpress dir
sudo rm -fR wordpress_files/*
sudo cp *_archive.zip wordpress_files/
sudo cp installer.php wordpress_files/
sudo chown -R www-data wordpress_files/
sudo chgrp -R www-data wordpress_files/
