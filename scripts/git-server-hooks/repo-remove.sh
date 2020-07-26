#!/bin/sh

[ $# -eq 0 ] && { echo "Usage: $0 -d <repo-dirname> \nExample:\n$0 -d my-node-app"; exit 1; }

# get the parameter -d's value
while getopts d: flag
do
    case "${flag}" in
        d) handle=${OPTARG};;
    esac
done

if [ -z "$handle" ]; then
    echo "missing parameter -d <repo-dirname>";
    exit -1;
fi

sudo rm -fr "/var/lib/docker/volumes/git-server-hooks_git-repos/_data/${handle}.git";
