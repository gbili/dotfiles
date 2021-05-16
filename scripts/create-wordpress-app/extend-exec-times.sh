#!/bin/bash

[ $# -eq 0 ] && { echo -e "Usage: $0 -r <reverse_domain> -d <host.domain> -s <dockerfile_sites_dir>"; exit 1; }

# get the parameter -d's value
while getopts d:m:p:r:s flag
do
    case "${flag}" in
        d) hostdomain=${OPTARG};;
        r) reversedomain=${OPTARG};;
        s) sitesdir=${OPTARG};;
    esac
done

if [ -z "$hostdomain" ]; then
    echo -e "missing parameter -d <host.com>";
    exit -1;
fi
if [ -z "$reversedomain" ]; then
    echo -e "missing parameter -r <reverse_domain>";
    exit -1;
fi
if [ -z "$sitesdir" ]; then
    sitesdir="$HOME/Documents/workspace/wordpress_sites"
    echo -e "No wordpress sites dir specified with option -s, using default";
    echo -e "$sitesdir";
fi

if [ ! -d "$sitesdir" ]; then
    echo "No sites dir, checked $sitesdir but not there. You likely have not passed the -s parameter or a wrong one";
    echo " Make sure to pass parent <sites_dir>, the one where $reversedomain is located at";
    echo "Exiting"
    exit -1;
fi

currdir="$(dirname "$(readlink -f "$0")")"
echo "Using default uploads.ini";
uploadsini="$currdir/uploads.ini";
nginxvhostsetting="$currdir/vhost/nginx-example-vhost-settings.com.tmpl"
echo "Using default $nginxvhostsetting";

domaindir="$sitesdir/$reversedomain"

if [ ! -d "$domaindir" ]; then
    echo -e "Directory $domaindir STILL DOES NOT exists.";
    echo -e "Exit";
    exit -1;
fi

cd $domaindir;
# prepare dir for docker-compose
cp "$uploadsini" "$domaindir/uploads.ini";
echo "Created, $domaindir/uploads.ini, make sure that it is USED in docker-compose.yml under volumes section:";
echo "- ./uploads.ini:/usr/local/etc/php/conf.d/uploads.ini";
echo "Otherwise there will be no effect in php";

if [ ! -d "$domaindir/vhost" ]; then
  echo "Creating a vhost dir to pass specific nginx settings for domain $hostdomain";
  mkdir -p "$domaindir/vhost";
fi

echo "Copying default nginx settings for domain $hostdomain, required by WP Duplicator";
cp "$nginxvhostsetting" "$domaindir/vhost/$hostdomain";

echo "Passing settings to nginx's vhost volume (named: nginx-proxy_vhost) via busybox";
# move to the directory where you have your my-domain.com conf file
cd "$domaindir/vhost"
# create a container on which we mount vhost at /data
docker container create --name tempx -v nginx-proxy_vhost:/data busybox
# copy contents of ./vhost into temp's container /data dir
docker cp . tempx:/data
# we can remove the container and keep the contents of vhost
docker rm tempx

echo "nginx-proxy_vhost now populated, but nginx-proxy has not absorbed it yet.";
echo "Let's restart nginx-proxy to take effect for the vhost settings of $hostdomain";

cd $HOME/Documents/workspace/nginx-proxy

docker rm -f nginx-proxy
docker rm -f nginx-proxy-gen
docker rm -f nginx-proxy-le
docker-compose up -d

echo "Nginx proxy restarted, should be aware of settings for $hostdomain";

echo "Move to $hostdomain dir and recompose docker";

cd $domaindir
# docker-compose down
docker-compose up -d
