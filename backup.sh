#!/bin/bash

CONTAINER=lab-eng-sw-mysql-1
DATABASE=candidatese
USER=root
BACKUP_DIR=backups

mkdir -p $BACKUP_DIR
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

docker exec $CONTAINER sh -c 'exec mysqldump -u '"$USER"' -p"$MYSQL_ROOT_PASSWORD" '"$DATABASE"'' > $BACKUP_DIR/backup_$DATE.sql

ls -t $BACKUP_DIR/backup_*.sql | tail -n +6 | xargs rm -f

echo "Backup realizado: $BACKUP_DIR/backup_$DATE.sql"
