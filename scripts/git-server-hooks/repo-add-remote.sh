#!/bin/bash

[ $# -eq 0 ] && { echo "Usage: $0 -d <dir_name>"; exit 1; }

# get the parameter -d's value
while getopts d: flag
do
    case "${flag}" in
        d) repodir=${OPTARG};;
    esac
done

if [ -z "$repodir" ]; then
    echo "missing parameter -d <dir_name>";
    exit -1;
fi

ssh ubuntu@45.157.190.21 '$HOME/dotfiles/scripts/git-server-hooks/repo-add.sh -d' $repodir;
