# Variables
DIR_BACKUP="/mnt/backups/system"
FECHA=$(date | awk -F' ' '{gsub(":", "-", $4); print "full"$1 $2 $3 "_" $4}')
DESTINO="$DIR_BACKUP/$FECHA"

DIRS="/etc /var /home /root /usr/local /opt /srv /boot"
FILES="/boot/grub/grub.cfg /etc/apt/sources.list"

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
  mkdir -p "$DESTINO"
  
  echo "Copiando directorios..."
  for dir in $DIRS; do
        rsync -aAXH --info=progress2 "$dir" "$DESTINO"
  done

  echo "Copiando archivos..."
  for file in $FILES;do
        rsync -aAXH --info=progress2 "$file" "$DESTINO$file"
  done
  echo "Directorios y archivos copiados"
  dpkg --get-selections > "$DESTINO/paquetes_instalados.list"

  echo "Compresión..."
  cd $DIR_BACKUP
  tar -czf $FECHA.tar.gz $FECHA
  rm -rf $FECHA
  echo "Realizado."
}

