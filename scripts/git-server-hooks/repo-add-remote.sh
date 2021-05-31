#!/bin/bash

echo " --- git-server-hooks (default remote is on g@199.241.137.4): $0 \n";
echo "This script will repo-add a git repository <repo_dirname>.git in the running git-server-hooks volume. \n";

[ $# -eq 0 ] && { echo -e "Usage: $0 -d <dir_name> -n <namespace> -u <username> -h <host>\n Example $0 -d my_node_app -n vanilla -u ubuntu -h 45.157.190.21"; exit 1; }

# get the parameter -d's value
while getopts d:n:u:h: flag
do
    case "${flag}" in
        d) repodir=${OPTARG};;
        n) hookns=${OPTARG};;
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
    username="g"
    echo -e "missing parameter -u <remote_username>, using default: $username";
fi

if [ -z "$hostname" ]; then
    hostname="199.241.137.4"
    echo -e "missing parameter -h <hostname_host_IP>, using default: $hostname";
fi

ssh "${username}@${hostname}" '$HOME/dotfiles/scripts/git-server-hooks/repo-add.sh -d' $repodir -n $hookns;
