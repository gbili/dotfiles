#!/bin/sh

# Create a registry
[ $# -eq 0 ] && { echo -e "Usage: $0 -d <fqdomainname> -u <user>"; exit 1; }

# get the parameter -d's value
while getopts d:u: flag
do
    case "${flag}" in
        d) fqdn=${OPTARG};;
        u) username=${OPTARG};;
    esac
done

cd;

gitserverhooksdir="$ws/git-server-hooks"

# create the basic directories required for the docker-gitserverhooks 

if [ ! -d "$gitserverhooksdir" ]; then
    echo -e "Directory $gitserverhooksdir DOES NOT exists.";
    mkdir -p "${gitserverhooksdir}"
fi

currdir="$(dirname "$(readlink -f "$0")")"

cp $currdir/docker-compose.tmpl.yml $gitserverhooksdir/docker-compose.yml

echo -e "Replacing fqdn into docker-compose.yml";
sed -i -e "s/PRIV_REG_HOST/$PRIV_REG_HOST/g" "$gitserverhooksdir/docker-compose.yml"
sed -i -e "s/DOMAIN.TLD/$fqdn/g" "$gitserverhooksdir/docker-compose.yml"
sed -i -e "s/REPO_USERNAME/$username/g" "$gitserverhooksdir/docker-compose.yml"

echo -e "We will try to docker-compose up -d";
cd "${gitserverhooksdir}";
docker-compose up -d
