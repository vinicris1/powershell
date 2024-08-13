#!/bin/bash

MCFOLDER="/mnt/backup/mc"
BACKUPFOLDER="/home/vinicin/backup"
DATE=$(date +"%Y-%m-%d_%H")

BACKUPNAME="backup_$DATE.tar.gz"

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
 
