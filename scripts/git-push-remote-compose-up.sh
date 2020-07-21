#!/bin/sh

[ $# -eq 0 ] && { echo "Usage: $0 -d <docker-compose.yml_parent_dir_last_part> \nExample:\n$0 -d blog2"; exit 1; }

while getopts d: flag
do
    case "${flag}" in
        d) compose_dirname=${OPTARG};;
    esac
done

git push live
ssh ubuntu@45.157.190.21 "docker-restart-service -d $compose_dirname";
