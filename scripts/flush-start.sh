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
      echo "missing parameter -t <tag>, using 0.0.5";
      tag="0.0.5";
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
      echo "missing parameter -t <tag>, using 0.0.1";
      tag="0.0.1";
  fi

  ./flush-start.sh -d git-server-hooks -t "0.0.5";

  cd "${domaindir}";
  docker rm -f ${handle};
  docker volume rm git-server-hooks_node-apps;
  docker rmi docker.zivili.ch/gbili/node-app-js:${tag};
  docker-compose up -d;
fi
