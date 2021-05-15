#!/bin/bash
[ $# -eq 0 ] && { echo -e "Usage: $0 -r <reverse_domain> -s <dockerfile_sites_dir> -c <1>"; exit 1; }

# get the parameter -d's value
while getopts r:s: flag
do
    case "${flag}" in
        r) reversedomain=${OPTARG};;
        s) sitesdir=${OPTARG};;
        c) confirm=${OPTARG};;
    esac
done

if [ -z "$reversedomain" ]; then
    echo -e "missing parameter -r <reverse_domain>";
    exit -1;
fi

currbasename=${PWD##*/}

if [ "$currbasename" != "$reversedomain" ]; then
    echo -e "you must cd into $reversedomain in order to run this command";
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

# clean wordpress dir
sudo rm -fR wordpress_files/*
sudo cp *_archive.zip wordpress_files/
sudo cp installer.php wordpress_files/
sudo chown -R www-data wordpress_files/
sudo chgrp -R www-data wordpress_files/

# Print credentials for easier setup
echo -e "Go to your browser under https://<site>/installer.php"
echo -e "and paste the below credentials in the interface: "
echo -e ""
echo -e "${reversedomain}_wp_db:3306"
echo -e "${reversedomain}_wp_db_name"
echo -e "${reversedomain}_wp_db_user"
echo -e "the -p <password>"
