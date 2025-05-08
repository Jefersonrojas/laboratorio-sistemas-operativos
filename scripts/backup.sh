#!/bin/bash

# Verificar si se proporcionó un directorio
if [ $# -eq 0 ]; then
    echo "Error: Debes especificar un directorio para respaldar"
    echo "Uso: $0 <directorio>"
    exit 1
fi

# Verificar si el directorio existe
if [ ! -d "$1" ]; then
    echo "Error: El directorio $1 no existe"
    exit 1
fi

# Obtener nombre base del directorio
DIR_NAME=$(basename "$1")

# Crear nombre del archivo con fecha (formato YYYYMMDD)
BACKUP_FILE="$HOME/laboratorio/respaldo/${DIR_NAME}_$(date +%Y%m%d).tar.gz"

# Crear el respaldo comprimido
echo "Creando respaldo de $1..."
tar -czf "$BACKUP_FILE" "$1" 2>/dev/null

# Verificar si el respaldo fue exitoso
if [ $? -eq 0 ]; then
    # Obtener tamaño del archivo
    SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo "Respaldo completado con éxito!"
    echo "Archivo creado: $(basename "$BACKUP_FILE")"
    echo "Tamaño: $SIZE"
    echo "Ubicación: $BACKUP_FILE"
else
    echo "Error: Fallo al crear el respaldo"
    exit 1
fi
