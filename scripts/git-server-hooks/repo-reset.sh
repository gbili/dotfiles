#!/bin/sh

[ $# -eq 0 ] && { echo "Usage: $0 -d <repo-dirname> -n <hook-namespace> \nExample:\n$0 -d my-node-app"; exit 1; }

# get the parameter -d's value
while getopts d:n: flag
do
    case "${flag}" in
        d) handle=${OPTARG};;
        n) hookns=${OPTARG};;
    esac
done

if [ -z "$handle" ]; then
    echo "missing parameter -d <repo-dirname>";
    exit -1;
fi

currdir="$(dirname "$(readlink -f "$0")")"

sudo $currdir/repo-remove.sh -d $handle

if [ -z "$hookns" ]; then
  sudo $currdir/repo-add.sh -d $handle
else
  sudo $currdir/repo-add.sh -d $handle -n $hookns
fi

