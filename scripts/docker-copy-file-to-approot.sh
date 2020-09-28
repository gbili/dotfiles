#!/bin/sh

[ $# -eq 0 ] && { echo "Usage: $0 -d <docker_app_dirname> -v <volume_name> -f <filename> -g <as_filename>\nExample:\n$0 -d cronide-project -v git-server-hooks_node-apps -f .env -g /cronide-project/.env"; exit 1; }

while getopts d:v:f:g: flag
do
    case "${flag}" in
        d) compose_dirname=${OPTARG};;
        v) volume_name=${OPTARG};;
        f) file_to_copy=${OPTARG};;
        g) copy_file_as=${OPTARG};;
    esac
done

ws=$HOME/Documents/workspace

currdir="$(dirname "$(readlink -f "$0")")"

compose_dir=$ws/$compose_dirname;

if [ ! -d ${compose_dir} ]; then
  echo "No such directory $compose_dir, exiting";
  exit 1;
fi

if [ -z ${volume_name} ]; then
  echo "You need to specify a volume name, exiting";
  exit 1;
fi

if [ ! -f ${compose_dir}/${file_to_copy} ]; then
  echo "$file_to_copy not found, exiting";
  exit 1;
fi

echo "Using the app root as path";
if [ -z ${copy_file_as} ]; then
  copy_file_as="/$compose_dirname/$file_to_copy"
else
  copy_file_as="/$compose_dirname/$copy_file_as"
fi

$currdir/docker-copy-file-to-volume.sh -d $compose_dirname -v $volume_name -f $file_to_copy -g $copy_file_as
