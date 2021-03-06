#!/bin/sh

echo -e " ###### We now need to add a Docker Registry to push our projects \n"

echo -e " ###### Installing Docker-Registry nginx-proxy \n"

cd ~/dotfiles/scripts/docker-registry

echo -e "Under what domain do you want to run the registry?"

read registryfdqn

echo -e "For what user do you want to run the registry?"

read registryuser

$HOME/dotfiles/scripts/docker-registry/install.sh -d $registryfdqn -u $registryuser

cd;
