#!/bin/sh

echo " --- git-server-hooks (locally): $0 \n";
echo "This script will repo-remove the git repository <repo_dirname>.git from the running git-server-hooks volume and try to create it again with repo-add. \n";

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

