#!/bin/bash

[ $# -eq 0 ] && { echo -e "Usage: $0 -r <reverse_domain> -d <host.domain> -p <wp_db_password> -m <mysql_root_password> -s <dockerfile_sites_dir>"; exit 1; }

# get the parameter -d's value
while getopts d:m:p:r:s flag
do
    case "${flag}" in
        d) hostdomain=${OPTARG};;
        m) mysqlrootpassword=${OPTARG};;
        p) wpdbpassword=${OPTARG};;
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
if [ -z "$mysqlrootpassword" ]; then
    echo -e "missing parameter -m <mysql_root_password>";
    exit -1;
fi
if [ -z "$wpdbpassword" ]; then
    echo -e "missing parameter -p <wp_db_password>";
    exit -1;
fi
if [ -z "$sitesdir" ]; then
    sitesdir="$HOME/Documents/workspace/wordpress_sites"
    echo -e "No wordpress sites dir specified with option -s, using default";
    echo -e "$sitesdir";
fi

if [ ! -d "$sitesdir" ]; then
    mkdir -p "$sitesdir"
fi

if [ ! -d "$sitesdir" ]; then
    echo -e "Sill no sites dir in: $sitesdir"
    echo -e "Exiting"
    exit -1;
fi

dockertmplname="docker-compose.wordpress.tmpl.yml";
dockertmpl="$sitesdir/$dockertmplname";

currdir="$(dirname "$(readlink -f "$0")")"
if [ ! -f "$dockertmpl" ]; then
    echo -e "Missing docker-compose.yml template, looking for: "$dockertmpl"";
    dockertmpl="$currdir/$dockertmplname";
    echo -e "Using default in $dockertmpl";
fi

echo "Using default uploads.ini";
uploadsini="$currdir/uploads.ini";
nginxvhostsetting="$currdir/vhost/nginx-example-vhost-settings.com.tmpl"
echo "Using default $nginxvhostsetting";

domaindir="$sitesdir/$reversedomain"

# cd to dir and create if not exists
if [ ! -d "$domaindir" ]; then
    echo -e "Directory $domaindir DOES NOT exists."
    echo -e "Creating $domaindir";
    mkdir -p $domaindir;
fi

if [ ! -d "$domaindir" ]; then
    echo -e "Directory $domaindir STILL DOES NOT exists.";
    echo -e "Exit";
    exit -1;
fi

cd $domaindir;
# prepare dir for docker-compose
cp "$dockertmpl" "$domaindir/docker-compose.yml";
cp "$uploadsini" "$domaindir/uploads.ini";
sed -i -e "s/REVERSE_DOMAIN/$reversedomain/g" "$domaindir/docker-compose.yml"
sed -i -e "s/DOMAIN.TLD/$hostdomain/g" "$domaindir/docker-compose.yml"
sed -i -e "s/WPDBPASSWORD/$wpdbpassword/g" "$domaindir/docker-compose.yml"
sed -i -e "s/MYSQLPASSWORD/$mysqlrootpassword/g" "$domaindir/docker-compose.yml"

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
docker-compose down
docker-compose up -d
