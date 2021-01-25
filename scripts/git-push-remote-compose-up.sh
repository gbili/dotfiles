#!/bin/sh
[ $# -eq 0 ] && { echo -e "Usage: $0 -d <dir_name> -u <username> -h <host>\n Example $0 -d my_node_app -u g -h 199.21.23.24"; exit 1; }

# get the parameter -d's value
while getopts d:n:u:h: flag
do
    case "${flag}" in
        d) repodir=${OPTARG};;
        u) username=${OPTARG};;
        h) hostname=${OPTARG};;
    esac
done

if [ -z "$repodir" ]; then
    echo -e "missing parameter -d <dir_name>";
    exit -1;
fi

if [ -z "$hookns" ]; then
    hookns="vanilla"
    echo -e "missing parameter -n <namespace>, using $hookns";
fi

if [ -z "$username" ]; then
    username="ubuntu"
    echo -e "missing parameter -u <remote_username>, using default: $username";
fi

if [ -z "$hostname" ]; then
    hostname="45.157.190.21"
    echo -e "missing parameter -h <hostname_host_IP>, using default: $hostname";
fi

git push live;

ssh "${username}@${hostname}" '$HOME/dotfiles/scripts/docker-restart-service.sh -d' $repodir;
