#!/bin/sh

[ $# -eq 0 ] && { echo -e "Usage: $0 -d <docker-compose-dir> -t <tag> \nExample:\n$0 -d git-server-hooks -t 0.0.5"; exit 1; }

# get the parameter -d's value
while getopts d:t: flag
do
    case "${flag}" in
        d) handle=${OPTARG};;
        t) tag=${OPTARG};;
    esac
done

domaindir="${ws}/${handle}"

if [ ! -d "$domaindir" ]; then
    echo -e "Directory $domaindir DOES NOT exists.";
    echo -e "Exiting";
    exit -1;
fi

# ---------- Git server hooks

if [ "${handle}" = "git-server-hooks" ]; then
  if [ -z "$tag" ]; then
      tag="0.1.0";
      echo -e "missing parameter -t <tag>, using ${tag}";
  fi

  PRIV_REG_HOST=$(${HOME}/dotfiles/scripts/private-registry-host.sh);
  cd "${domaindir}";
  docker rm -f ${handle};
  docker rmi $($PRIV_REG_HOST)/gbili/${handle}:${tag};
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
