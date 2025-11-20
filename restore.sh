#!/bin/bash

read -p "Introduzca una búsqueda por full o incremental. Nota: Si vas a restaurar por primera vez busca por full. (full/incremental): " busqueda
mas_reciente=$(ls -1dt /mnt/backups/system/* | grep $busqueda | head -n 1)

if [[ $busqueda == 'full' ]]; then
	echo "Encontrada la copia de seguridad más reciente: $mas_reciente"
else
	echo "Encontrada la copia de seguridad más reciente: $mas_reciente"
fi

#copia
read -p "¿Estás seguro de que quieres restaurar el sistema a ese estado?(s/n)" respuesta

if [[ $respuesta == 's' ]]; then
	echo "Restaurando copia de seguridad..."
        tar -xzf $mas_reciente
	rsync -aAXH --info=progress2 "$mas_reciente"  /
	dpkg --set-selections "$mas_reciente/paquetes_instalados.list"
else
	echo "Saliendo del script..."
fi
