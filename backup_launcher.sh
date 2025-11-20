#!/bin/bash
# Script que decide qué backup ejecutar

# Día de la semana (1=Lunes)
DIA_SEMANA=$(date +%u)
DIA_MES=$(date +%d)

# Ejecutar full mensual si es primer día del mes
if [ "$DIA_MES" -eq 1 ]; then
    echo "Ejecutando backup full mensual..."
    /usr/local/sbin/backup/full_backup.sh monthly
# Ejecutar full semanal si es lunes
elif [ "$DIA_SEMANA" -eq 1 ]; then
    echo "Ejecutando backup full semanal..."
    /usr/local/sbin/backup/full_backup.sh weekly
else
    echo "Ejecutando backup incremental diario..."
    /usr/local/sbin/backup/incremental_backup.sh daily
fi
