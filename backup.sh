#!/bin/bash
# Roberto Martín Rivera

# Variables
DIR_BACKUP="/var/backups/system"
FECHA=$(date | awk -F' '  '{print $1 $2 $3 $4 "_" $5}')
DESTINO="$DIR_BACKUP$FECHA"

DIRS="/etc /var /home /root /usr/local /opt /srv /boot"
FILES="/boot/grub/grub.cfg /etc/apt/sources.list"

if [[ $UID -ne 0 ]]; then
	echo "El usuario actual no tiene permisos para ejecutar este script."
	exit 1
fi

# Copia de los directorios

mkdir -p "$DESTINO"

for dir IN $DIRS; do
	rsync -aAXH "$dir" "$DESTINO"
done

for file IN $FILES;do
	rsync -aAXH "$file" "$DESTINO$file"
done

dpkg --get-selections > "$DESTINO/paquetes_instalados.list
#ver opcion --delete para restore
