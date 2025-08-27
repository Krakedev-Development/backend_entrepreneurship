#!/bin/bash

set -e

echo "🧹 [CLEANUP] Iniciando limpieza de Docker..."

# Detener y eliminar contenedores
echo "🛑 [CLEANUP] Deteniendo contenedores..."
docker-compose down --remove-orphans

# Eliminar imágenes
echo "🗑️ [CLEANUP] Eliminando imágenes..."
docker-compose down --rmi all

# Eliminar volúmenes
echo "🗑️ [CLEANUP] Eliminando volúmenes..."
docker-compose down --volumes

# Eliminar redes
echo "🗑️ [CLEANUP] Eliminando redes..."
docker-compose down --remove-orphans

# Limpiar imágenes no utilizadas
echo "🧹 [CLEANUP] Limpiando imágenes no utilizadas..."
docker image prune -f

# Limpiar contenedores no utilizados
echo "🧹 [CLEANUP] Limpiando contenedores no utilizados..."
docker container prune -f

# Limpiar volúmenes no utilizados
echo "🧹 [CLEANUP] Limpiando volúmenes no utilizados..."
docker volume prune -f

# Limpiar redes no utilizadas
echo "🧹 [CLEANUP] Limpiando redes no utilizadas..."
docker network prune -f

echo "✅ [CLEANUP] Limpieza completada exitosamente"
