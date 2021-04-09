#!/bin/sh

[ $# -eq 0 ] && { echo -e "Usage: $0 -d <db-parent-project-dirname> \nExample:\n$0 -d cronide-project"; exit 1; }

while getopts d: flag
do
    case "${flag}" in
        d) compose_dirname=${OPTARG};;
    esac
done

ws=$HOME/Documents/workspace

compose_dir=$ws/$compose_dirname;

if [ ! -d ${compose_dir} ]; then
  echo -e "No such directory $compose_dir, exiting";
  exit 1;
fi

backup_filename=$(date +"%y-%m-%d").sql;
echo -e "Running mysqldump within docker container: \n"
docker exec -it ${compose_dirname}-db /bin/sh -c "cd /var/lib/mysql && mysqldump -u ${compose_dirname}_user -p -R ${compose_dirname}_db > ${backup_filename}"

db_backups_dir=${compose_dir}/docker-db-backups

if [ ! -d ${db_backups_dir} ]; then
  mkdir ${db_backups_dir};
fi
echo -e "Moving SQL dump file to ${db_backups_dir}:\n"
sudo mv /var/lib/docker/volumes/${compose_dirname}_mysql/_data/${backup_filename} ${db_backups_dir}/
echo -e "Giving you ($USER) ownership on ${db_backups_dir}/*:\n"
sudo chown -R $USER:$USER ${db_backups_dir}/

echo -e "Creating simbolic link to latest backup:\n"
ln -fs ${db_backups_dir}/${backup_filename} ${db_backups_dir}/latest-backup.sql

more ${db_backups_dir}/latest-backup.sql
