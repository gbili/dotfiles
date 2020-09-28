#!/bin/bash

[ $# -eq 0 ] && { echo "Usage: $0 -d <dir_name> -n <namespace>, example $0 -d my_node_app -n vanilla|node"; exit 1; }

# get the parameter -d's value
while getopts d:n: flag
do
    case "${flag}" in
        d) repodir=${OPTARG};;
        n) hookns=${OPTARG};;
    esac
done

if [ -z "$repodir" ]; then
    echo "missing parameter -d <dir_name>";
    exit -1;
fi

if [ -z "$hookns" ]; then
    hookns="vanilla"
    echo "missing parameter -n <namespace>, using $hookns";
fi

ssh ubuntu@45.157.190.21 '$HOME/dotfiles/scripts/git-server-hooks/repo-add.sh -d' $repodir -n $hookns;
