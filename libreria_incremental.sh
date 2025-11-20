#!/bin/bash
# Variables
DIR_BACKUP="/mnt/backups/system"
FECHA=$(date | awk -F' ' '{gsub(":", "-", $4); print "incremental"$1 $2 $3 "_" $4}')
DESTINO="$DIR_BACKUP/$FECHA"
mas_reciente=$(ls -1dt /mnt/backups/system/* | head -n 1)
DIRS="/etc /var /home /root /usr/local /opt /srv /boot"
FILE="/etc/apt/sources.list"
# Funciones
function f_salir(){
  echo -e "$saliendo del script..."
  sleep 3
  kill -15 $$
}

function f_root(){
  if [[ $UID -ne 0 ]]; then
        echo "El usuario actual no tiene permisos para ejecutar este script."
        exit 1
  fi
}

function f_copia(){
  echo "Copia más reciente encontrada: $mas_reciente"
  mkdir -p "$DESTINO"
  
  for dir in $DIRS; do
  	echo "Copiando directorios y archivos..."
#	tar -xzf $mas_reciente
  	rsync -aAXH --info=progress2 --link-dest="$mas_reciente" "$dir"  "$DESTINO"
  done
  rsync -aAX --info=progress2 "$FILE" "$DESTINO$FILE"

  echo "Obteniendo paquetes..."
  dpkg --get-selections > "$DESTINO/paquetes_instalados.list"

  echo "Compresión..."
  cd $DIR_BACKUP
  tar -czf $FECHA.tar.gz $FECHA
  rm -rf $FECHA
  echo "Realizado."
}
