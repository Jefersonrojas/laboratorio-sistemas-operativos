#!/bin/bash
# Script de información del sistema
# Versión 1.0

echo "=== Información del Sistema ==="
echo "Usuario: $USER"
echo "Hostname: $(hostname)"
echo "Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "=== Espacio en disco ==="
df -h | grep -E "/dev/|tmpfs|Filesystem"

echo "=== Memoria ==="
free -h

echo "=== Procesos en ejecución ==="
ps aux | head -n 5
