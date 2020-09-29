#!/bin/sh

# https://gabrieltanner.org/blog/docker-registry

# We will need this to generate the password
sudo apt install apache2-utils

# Create a registry
[ $# -eq 0 ] && { echo "Usage: $0 -d <fqdomainname> -u <user>"; exit 1; }

# get the parameter -d's value
while getopts d:u: flag
do
    case "${flag}" in
        d) fqdn=${OPTARG};;
        u) username=${OPTARG};;
    esac
done

cd;

registrydir="$ws/docker-registry"

# create the basic directories required for the docker-registry 

if [ ! -d "$registrydir" ]; then
    echo "Directory $registrydir DOES NOT exists.";
    mkdir -p "${registrydir}"
fi

if [ ! -d "${registrydir}/auth" ]; then
    echo "Directory $registrydir/auth DOES NOT exists.";
    mkdir -p "${registrydir}/auth"
fi

if [ ! -d "${registrydir}/vhost" ]; then
    echo "Directory $registrydir/vhost DOES NOT exists.";
    mkdir -p "${registrydir}/vhost"
fi

currdir="$(dirname "$(readlink -f "$0")")"

cp $currdir/docker-compose.tmpl.yml $registrydir/docker-compose.yml

echo "Replacing fqdn into docker-compose.yml";
sed -i -e "s/DOMAIN.TLD/$fqdn/g" "$registrydir/docker-compose.yml"

# Let's Encrypt certbot will look for a vhost nginx conf file
# and we need to tell it to allow larger files
echo "Enableing larger files for larger images";
cp $currdir/vhost/sample.host $registrydir/vhost/$fqdn

# Let's create a password
echo "You will now decide what password to use for ${username}";
cd "${registrydir}/auth"
htpasswd -Bc registry.password $username

echo "We will try to docker-compose up --force-recreate"
cd "${registrydir}"
docker-compose up --force-recreate

echo "Do not forget to login before pushing with:\n docker login $fqdn:5000\n";
echo "You can now: docker-build-push -t $fqdn/$username/myapp-react:0.0.2";

