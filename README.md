# 📚 INFORME TÉCNICO: LABORATORIO DE SISTEMAS OPERATIVOS

## 🔍 INTRODUCCIÓN
Este repositorio documenta los ejercicios prácticos realizados durante el laboratorio de Sistemas Operativos, implementando scripts Bash para administración avanzada del sistema.

## 🧰 HERRAMIENTAS IMPLEMENTADAS

### 1. SISTEMA DE BACKUP AUTOMATIZADO (`backup.sh`)
```bash
# Características principales:
# - Compresión en tar.gz con marca temporal
# - Validación de parámetros
# - Reporte de tamaño y ubicación
# - Histórico de versiones
## Top 5 Logs Más Grandes
| Archivo          | Tamaño | Errores |
|------------------|--------|---------|
| /var/log/syslog  | 12MB   | 23      |

## Últimos 3 Errores
- 2023-08-15 14:30:45 Error de conexión
