#!/bin/bash

set -e

echo "🏥 [HEALTH-CHECK] Verificando salud del backend..."

# Verificar que el puerto esté abierto
if nc -z localhost 3000 2>/dev/null; then
    echo "✅ [HEALTH-CHECK] Puerto 3000 está abierto"
else
    echo "❌ [HEALTH-CHECK] Puerto 3000 no está abierto"
    exit 1
fi

# Verificar que la API responda
if curl -f http://localhost:3000/api/v1/ > /dev/null 2>&1; then
    echo "✅ [HEALTH-CHECK] API responde correctamente"
else
    echo "❌ [HEALTH-CHECK] API no responde"
    exit 1
fi

# Verificar que Swagger esté disponible
if curl -f http://localhost:3000/api/docs > /dev/null 2>&1; then
    echo "✅ [HEALTH-CHECK] Documentación Swagger disponible"
else
    echo "❌ [HEALTH-CHECK] Documentación Swagger no disponible"
    exit 1
fi

# Verificar conexión a la base de datos
if curl -f http://localhost:3000/api/v1/negocios > /dev/null 2>&1; then
    echo "✅ [HEALTH-CHECK] Conexión a base de datos OK"
else
    echo "❌ [HEALTH-CHECK] Error en conexión a base de datos"
    exit 1
fi

echo "🎉 [HEALTH-CHECK] Todas las verificaciones pasaron exitosamente"
