#!/bin/bash

[ $# -eq 0 ] && { echo "Usage: $0 -r <reverse_domain> -d <host.domain> -p <wp_db_password> -m <mysql_root_password>"; exit 1; }

# get the parameter -d's value
while getopts d:m:p:r: flag
do
    case "${flag}" in
        d) hostdomain=${OPTARG};;
        m) mysqlrootpassword=${OPTARG};;
        p) wpdbpassword=${OPTARG};;
        r) reversedomain=${OPTARG};;
    esac
done

if [ -z "$hostdomain" ]; then
    echo "missing parameter -d <host.com>";
    exit -1;
fi
if [ -z "$reversedomain" ]; then
    echo "missing parameter -r <reverse_domain>";
    exit -1;
fi
if [ -z "$mysqlrootpassword" ]; then
    echo "missing parameter -m <mysql_root_password>";
    exit -1;
fi
if [ -z "$wpdbpassword" ]; then
    echo "missing parameter -p <wp_db_password>";
    exit -1;
fi

sitesdir="/home/ubuntu/Documents/workspace/sites"
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

# prepare dir for docker-compose
cp "$sitesdir/docker-compose.yml.wordpress.tmpl" "$domaindir/docker-compose.yml";
sed -i -e "s/REVERSE_DOMAIN/$reversedomain/g" "$domaindir/docker-compose.yml"
sed -i -e "s/DOMAIN.TLD/$hostdomain/g" "$domaindir/docker-compose.yml"
sed -i -e "s/WPDBPASSWORD/$wpdbpassword/g" "$domaindir/docker-compose.yml"
sed -i -e "s/MYSQLPASSWORD/$mysqlrootpassword/g" "$domaindir/docker-compose.yml"

docker-compose up -d
