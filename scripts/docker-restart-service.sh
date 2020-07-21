#!/bin/sh

[ $# -eq 0 ] && { echo "Usage: $0 -d <docker-compose.yml_parent_dir_last_part> \nExample:\n$0 -d blog2"; exit 1; }

while getopts d: flag
do
    case "${flag}" in
        d) compose_dirname=${OPTARG};;
    esac
done

compose_dir=$ws/$compose_dirname;

if [ ! -d ${compose_dir} ]; then
  echo "No such directory, exiting";
  exit 1;
fi
if [ ! -f ${compose_dir}/docker-compose.yml ]; then
  echo "Docker-compose.yml not found, exiting";
  exit 1;
fi

echo "Changin directory to ${compose_dir}";
cd ${compose_dir};

echo "Will restart docker container";
docker-compose restart;
