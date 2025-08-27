#!/bin/bash

set -e

echo "🔍 [QUICK-CHECK] Verificando configuración del backend..."

# Verificar que Docker esté instalado
if ! command -v docker &> /dev/null; then
    echo "❌ [QUICK-CHECK] Docker no está instalado"
    exit 1
fi

# Verificar que Docker Compose esté instalado
if ! command -v docker-compose &> /dev/null; then
    echo "❌ [QUICK-CHECK] Docker Compose no está instalado"
    exit 1
fi

# Verificar que Node.js esté instalado
if ! command -v node &> /dev/null; then
    echo "❌ [QUICK-CHECK] Node.js no está instalado"
    exit 1
fi

# Verificar que npm esté instalado
if ! command -v npm &> /dev/null; then
    echo "❌ [QUICK-CHECK] npm no está instalado"
    exit 1
fi

# Verificar archivos necesarios
echo "📁 [QUICK-CHECK] Verificando archivos necesarios..."

required_files=(
    "Dockerfile"
    "docker-compose.yml"
    "package.json"
    "prisma/schema.prisma"
    "scripts/init.sh"
    "src/main.ts"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ [QUICK-CHECK] Archivo faltante: $file"
        exit 1
    fi
done

echo "✅ [QUICK-CHECK] Todos los archivos necesarios están presentes"

# Verificar que el archivo .env exista
if [ ! -f ".env" ]; then
    echo "📝 [QUICK-CHECK] Archivo .env no encontrado, copiando desde env.example..."
    cp env.example .env
    echo "✅ [QUICK-CHECK] Archivo .env creado"
else
    echo "✅ [QUICK-CHECK] Archivo .env encontrado"
fi

# Verificar que las dependencias estén instaladas
if [ ! -d "node_modules" ]; then
    echo "📦 [QUICK-CHECK] Dependencias no instaladas, instalando..."
    npm install
    echo "✅ [QUICK-CHECK] Dependencias instaladas"
else
    echo "✅ [QUICK-CHECK] Dependencias encontradas"
fi

# Verificar que la aplicación esté compilada
if [ ! -f "dist/src/main.js" ]; then
    echo "🔧 [QUICK-CHECK] Aplicación no compilada, compilando..."
    npm run build
    echo "✅ [QUICK-CHECK] Aplicación compilada"
else
    echo "✅ [QUICK-CHECK] Aplicación compilada"
fi

# Verificar permisos de scripts
echo "🔧 [QUICK-CHECK] Verificando permisos de scripts..."
chmod +x scripts/*.sh

echo "✅ [QUICK-CHECK] Permisos de scripts configurados"

# Verificar puertos disponibles
echo "🔌 [QUICK-CHECK] Verificando puertos disponibles..."

ports_to_check=(3000 5432 5050)

for port in "${ports_to_check[@]}"; do
    if netstat -tuln 2>/dev/null | grep -q ":$port "; then
        echo "⚠️  [QUICK-CHECK] Puerto $port está en uso"
    else
        echo "✅ [QUICK-CHECK] Puerto $port disponible"
    fi
done

echo "🎉 [QUICK-CHECK] Verificación completada exitosamente"
echo ""
echo "📋 [QUICK-CHECK] Para iniciar el backend:"
echo "   docker-compose up --build -d"
echo ""
echo "📋 [QUICK-CHECK] Para ver logs:"
echo "   docker-compose logs -f"
echo ""
echo "📋 [QUICK-CHECK] Para detener:"
echo "   docker-compose down"
