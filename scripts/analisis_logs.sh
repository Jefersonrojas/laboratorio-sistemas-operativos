#!/bin/bash

# Configuración inicial
OUTPUT_DIR="$HOME/laboratorio/datos/salida"
REPORT_FILE="$OUTPUT_DIR/informe_logs.md"
mkdir -p "$OUTPUT_DIR"

# Encabezado del informe
echo "# Análisis de Logs del Sistema" > "$REPORT_FILE"
echo "## Fecha: $(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 1. Buscar archivos .log y encontrar los 5 más grandes
echo "## Archivos de log más grandes" >> "$REPORT_FILE"
echo "| Archivo | Tamaño | Errores |" >> "$REPORT_FILE"
echo "|---------|--------|---------|" >> "$REPORT_FILE"

# Procesar los 5 logs más grandes
LOG_FILES=$(find /var/log -type f -name "*.log" -exec du -h {} + | sort -rh | head -n 5 | cut -f2)

declare -A error_counts
max_errors=0
most_error_log=""

for log_file in $LOG_FILES; do
    # Contar errores (case insensitive)
    errors=$(grep -i -c "error" "$log_file")
    error_counts["$log_file"]=$errors
    
    # Actualizar log con más errores
    if [ $errors -gt $max_errors ]; then
        max_errors=$errors
        most_error_log="$log_file"
    fi
    
    # Obtener tamaño legible
    size=$(du -h "$log_file" | cut -f1)
    
    # Agregar a la tabla
    echo "| $log_file | $size | $errors |" >> "$REPORT_FILE"
done

# 2. Mostrar los 3 últimos errores del log con más errores
if [ -n "$most_error_log" ] && [ $max_errors -gt 0 ]; then
    echo "" >> "$REPORT_FILE"
    echo "## Últimos 3 errores encontrados en $most_error_log" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    grep -i "error" "$most_error_log" | tail -n 3 | while read -r line; do
        echo "- \`$line\`" >> "$REPORT_FILE"
    done
fi

# Resumen por pantalla
echo ""
echo "=== RESUMEN DEL ANÁLISIS DE LOGS ==="
echo "Informe generado en: $REPORT_FILE"
echo ""
echo "Archivos analizados:"
for log_file in $LOG_FILES; do
    echo "- ${log_file}: ${error_counts["$log_file"]} errores"
done
echo ""
if [ -n "$most_error_log" ]; then
    echo "Archivo con más errores: $most_error_log ($max_errors errores)"
else
    echo "No se encontraron errores en los logs analizados"
fi
echo ""
