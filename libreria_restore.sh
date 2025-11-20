#!/usr/bin/bash
# Roberto Martín Rivera
DIRECTORIO="/mnt/backups/system"

echo "Copias de seguridad disponibles:"
ls -1 "$DIRECTORIO"

f_select_backup() {
    read -p "Introduzca el nombre exacto de la copia que desea restaurar: " copia

    while [[ ! -f "$DIRECTORIO/$copia" ]]; do
        echo "Nombre erróneo o archivo no encontrado. Intente de nuevo."
        read -p "Introduzca el nombre exacto de la copia que desea restaurar: " copia
    done
}

f_copia_backup() {
#copia
    read -p "¿Estás seguro de que quieres restaurar el sistema a ese estado?(s/n)" respuesta

    if [[ $respuesta == 's' ]]; then
        echo "Restaurando copia de seguridad..."
        tar -xzf $DIRECTORIO/$copia
        rsync -aAXH --info=progress2 "$DIRECTORIO/$copia"  /
        dpkg --set-selections "$DIRECTORIO/$copia/paquetes_instalados.list"
    else
        echo "Saliendo del script..."
    fi
}
