#!/bin/sh

[ $# -eq 0 ] && { echo "Usage: $0 -d <db-parent-project-dirname> \nExample:\n$0 -d cronide-project"; exit 1; }

while getopts d: flag
do
    case "${flag}" in
        d) compose_dirname=${OPTARG};;
    esac
done

ws=$HOME/Documents/workspace

compose_dir=$ws/$compose_dirname;

if [ ! -d ${compose_dir} ]; then
  echo "No such directory $compose_dir, exiting";
  exit 1;
fi

db_backups_dir=${compose_dir}/docker-db-backups

if [ ! -d ${db_backups_dir} ]; then
  echo "Cannot find backups dir";
  exit 1;
fi

backup_filename=latest-backup.sql;
backup_file=${db_backups_dir}/${backup_filename};

if [ ! -f ${backup_file} ]; then
  echo "No backup file $backup_file";
  exit 1;
fi

echo "Copying latest SQL dump file to docker volume:\n"
sudo cp ${backup_file} /var/lib/docker/volumes/${compose_dirname}_mysql/_data/${backup_filename}

echo "Restoring backup with mysqldump into docker container: \n"
docker exec -it ${compose_dirname}-db /bin/sh -c "cd /var/lib/mysql && mysql -u ${compose_dirname}_user -p ${compose_dirname}_db < ${backup_filename}"

echo "Done!";
