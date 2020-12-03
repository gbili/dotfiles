#!/bin/sh

echo -e " --- git-server-hooks (locally): $0 \n";
echo -e "This script will remove the git repository <repo_dirname>.git from the running git-server-hooks volume. \n";

[ $# -eq 0 ] && { echo -e "Usage: $0 -d <repo-dirname> \nExample:\n$0 -d my-node-app\n"; exit 1; }

# get the parameter -d's value
while getopts d: flag
do
    case "${flag}" in
        d) handle=${OPTARG};;
    esac
done

if [ -z "$handle" ]; then
    echo -e "missing parameter -d <repo-dirname>";
    exit -1;
fi

sudo rm -fr "/var/lib/docker/volumes/git-server-hooks_git-repos/_data/${handle}.git";
