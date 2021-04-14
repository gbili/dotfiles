#!/bin/bash

[ $# -eq 0 ] && { echo -e "Usage: $0 -d <docker-compose-dir> -t <tag> \nExample:\n$0 -d git-server-hooks -t 0.0.5"; exit 1; }

# get the parameter -d's value
while getopts d:t: flag
do
    case "${flag}" in
        d) handle=${OPTARG};;
        t) tag=${OPTARG};;
    esac
done

echo "Input was -d ${handel}, -t ${tag}";


domaindir="${ws}/${handle}"

echo "Domain dir is ${domaindir}";

if [ ! -d "$domaindir" ]; then
    echo -e "Directory $domaindir DOES NOT exists.";
    echo -e "Exiting";
    exit -1;
fi

# ---------- Git server hooks

if [ "${handle}" = "git-server-hooks" ] || [ "${handle}" = "cronide-react" ] ; then
  if [ -z "$tag" ]; then
      tag="0.1.0";
      echo -e "missing parameter -t <tag>, using ${tag}";
  fi

  PRIV_REG_HOST=$(${HOME}/dotfiles/scripts/private-registry-host.sh);
  sleep 2;
  imgtag=${$PRIV_REG_HOST};
  echo "${imgtag}";
  imgtag="${imgtag}/gbili/${handle}:${tag}";
  echo "cd: ${domaindir}";
  cd "${domaindir}";
  pwd;
  echo "docker rm -f: ${handle}";
  docker rm -f ${handle};
  echo "docker rmi ${imgtag}";
  docker rmi ${imgtag};
  echo "docker-compose up -d";
  docker-compose up -d;
fi

# --------- Blog with Git server hooks

if [ "${handle}" = "blog2" ]; then
  if [ -z "$tag" ]; then
      echo -e "missing parameter -t <tag>, exit";
      exit 1;
  fi

  # delete the application container
  docker rm -f ${handle};

  # Delete the source repository of the app and create a new empty one
  sudo rm -fr "/var/lib/docker/volumes/git-server-hooks_node-apps/_data/${handle}";
  sudo rm -fr "/var/lib/docker/volumes/git-server-hooks_git-repos/_data/${handle}.git";
  git-repoadd -d $handle;

  # IMPORTANT: make sure to git push after these commands
fi

echo "We haven't done much";
