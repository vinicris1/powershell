#!/bin/bash

MCFOLDER="/mnt/backup/mc"
BACKUPFOLDER="/home/vinicin/backup"
DATE=$(date +"%Y-%m-%d_%H")

BACKUPNAME="backup_$DATE.tar.gz"

FILES=$(ls | sed -E 's/.*-([0-9]{2})_.*/\1/' | xargs -n1)
DELDATE=$(date -d "7 days ago" +"%d")

cd /home/vinicin/backup

for file in $(ls); do
  FILEDATE=$(echo $file | sed -E 's/.*-([0-9]{2})_.*/\1/')
  if [ "$FILEDATE" == "$DELDATE" ]; then
    echo "Deleting $file"
    rm -rf "$file"
  fi
done

if [ ! -e "$MCFOLDER" ]; then
	echo "Diretorio nao existe"
	mount -t virtiofs backup /mnt/backup
else
	echo "Diretorio já existe"
fi

tar -czf "$BACKUPFOLDER/$BACKUPNAME" -C "$MCFOLDER" .

if [ $? -eq 0 ]; then
	echo "Backup executado: $BACKUPFOLDER/$BACKUPNAME"
else
	echo "Falha no backup"
fi
 
