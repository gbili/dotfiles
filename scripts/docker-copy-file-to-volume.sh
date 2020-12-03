#!/bin/sh

[ $# -eq 0 ] && { echo -e "Usage: $0 -d <docker_app_dirname> -v <volume_name> -f <filename> -g <as_filename>\nExample:\n$0 -d cronide-project -v git-server-hooks_node-apps -f .env -g /cronide-project/.env"; exit 1; }

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

compose_dir=$ws/$compose_dirname;

if [ ! -d ${compose_dir} ]; then
  echo -e "No such directory $compose_dir, exiting";
  exit 1;
fi

if [ -z ${volume_name} ]; then
  echo -e "You need to specify a volume name, exiting";
  exit 1;
fi

if [ ! -f ${compose_dir}/${file_to_copy} ]; then
  echo -e "$file_to_copy not found, exiting";
  exit 1;
fi

if [ -z ${copy_file_as} ]; then
  copy_file_as=""
  echo -e "Using the root as path";
fi

# move to the directory where you placed the public key
echo -e "Changin directory to ${compose_dir}";
cd ${compose_dir};

# create a container on which we mount git-server-hooks_ssh-keys at /data
echo -e "Will copy $compose_dir/$file_to_copy into temp:/data$copy_file_as";
docker container create --name temp -v $volume_name:/data busybox
# copy contents of ./some_temp_dir... into temp's container /data dir
docker cp $file_to_copy temp:/data$copy_file_as
# we can remove the container, and still keep the contents
docker rm temp
