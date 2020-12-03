#!/bin/bash

echo " --- git-server-hooks (locally): $0 \n";
echo "This script will repo-add a git repository <repo_dirname>.git in the running git-server-hooks volume. \n";
echo "!! MAKE SURE TO HAVE AN IMAGE OF git-server-hooks-repo-add in your local registry. \n";

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


currdir="$(dirname "$(readlink -f "$0")")"

# prepare dir for docker-compose
ls -la $currdir;

cp $currdir/docker-compose.repo-add.tmpl.yml $currdir/docker-compose.yml;

sed -i -e "s/PRIV_REG_SERVER/$PRIV_REG_SERVER/g" "$currdir/docker-compose.yml";
sed -i -e "s/GIT_REPO_DIRNAME/$repodir/g" "$currdir/docker-compose.yml";
sed -i -e "s/GIT_HOOK_NS/$hookns/g" "$currdir/docker-compose.yml";

docker-compose -f $currdir/docker-compose.yml up

echo "\nYour repo $repodir, has been created, you can now do:\n\ngit remote add live ssh://git@githook.co:2222/u/gbili/$repodir.git";

echo "Cleaning up";
rm $currdir/docker-compose.yml;
