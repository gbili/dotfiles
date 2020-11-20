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
    sitesdir="$HOME/Documents/workspace/wordpress_sites"
    echo "No wordpress sites dir specified with option -s, using default";
    echo "$sitesdir";
fi

domaindir="$sitesdir/$reversedomain"

# cd to dir and create if not exists
if [ ! -d "$domaindir" ]; then
    echo "Directory $domaindir DOES NOT exists."
    echo "Creating $domaindir";
    mkdir -p $domaindir;
fi

if [ ! -d "$domaindir" ]; then
    echo "Directory $domaindir STILL DOES NOT exists.";
    echo "Exit";
    exit -1;
fi

cd $domaindir;

wpdir="$domaindir/wordpress_files";
wpconfigpath="$wpdir/wp-config.php"

# prepare wp-config.php for https
echo "Backing up existing wp-config.php in parent dir";
cp "$wpconfigpath" "$domaindir/wp-config.php.back";

echo "Doing in place insertion of HTTPS activation";
sudo sed -i '1 a if \(isset\($_SERVER["HTTP_X_FORWARDED_PROTO"]\) && $_SERVER["HTTP_X_FORWARDED_PROTO"] === "https"\) $_SERVER["HTTPS"] = "on";' "$wpconfigpath"
