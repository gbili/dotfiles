#!/bin/sh

[ $# -eq 0 ] && { echo "Usage: $0 -d <docker-compose-dir> -t <tag> \nExample:\n$0 -d git-server-hooks -t 0.0.5"; exit 1; }

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
    echo "Directory $domaindir DOES NOT exists.";
    echo "Exiting";
    exit -1;
fi

# ---------- Git server hooks

if [ "${handle}" = "git-server-hooks" ]; then
  if [ -z "$tag" ]; then
      tag="0.1.0";
      echo "missing parameter -t <tag>, using ${tag}";
  fi

  cd "${domaindir}";
  docker rm -f ${handle};
  docker volume rm ${handle}_git-repos;
  docker rmi docker.zivili.ch/gbili/${handle}:${tag};
  docker-compose up -d;
fi

# --------- Blog with Git server hooks

if [ "${handle}" = "blog" ]; then
  if [ -z "$tag" ]; then
      tag="0.0.1";
      echo "missing parameter -t <tag>, using ${tag}";
  fi

  $0 -d git-server-hooks -t "0.1.0";

  cd "${domaindir}";
  docker rm -f ${handle};
  docker volume rm git-server-hooks_node-apps;
  docker rmi docker.zivili.ch/gbili/node-app-js:${tag};
  docker-compose up -d;
fi

# --------- Blog with Git server hooks

if [ "${handle}" = "blog2" ]; then
  if [ -z "$tag" ]; then
      tag="0.0.4";
      echo "missing parameter -t <tag>, using ${tag}";
  fi

  sudo rm -fr /var/lib/docker/volumes/git-server-hooks_node-apps/_data/${handle};
  sudo rm -fr "/var/lib/docker/volumes/git-server-hooks_git-repos/_data/${handle}.git";

  cd "${ws}/git-server-hooks-repo-add";
  docker-compose up -d;

  cd "${domaindir}";
  docker rm -f ${handle};
  docker rmi -f docker.zivili.ch/gbili/git-server-hooks-repo-add:${tag};
fi
