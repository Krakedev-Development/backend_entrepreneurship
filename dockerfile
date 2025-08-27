# Usar la imagen oficial de Node.js 20
FROM node:20-alpine

# Instalar dependencias del sistema necesarias
RUN apk add --no-cache bash netcat-openbsd

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias primero para aprovechar la caché de Docker
COPY package*.json ./
COPY prisma ./prisma/

# Instalar todas las dependencias (incluyendo devDependencies para la compilación)
RUN npm ci --only=production=false

# Generar el cliente de Prisma
RUN npx prisma generate

# Copiar el código fuente
COPY . .

# Hacer los scripts ejecutables
RUN chmod +x scripts/*.sh

# Compilar la aplicación
RUN npm run build

# Verificar que la compilación fue exitosa
RUN ls -la dist/

# Crear usuario no-root para seguridad
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nestjs -u 1001

# Cambiar propiedad de los archivos al usuario no-root
RUN chown -R nestjs:nodejs /app

# Exponer el puerto
EXPOSE 3000

# Variables de entorno por defecto
ENV NODE_ENV=production
ENV PORT=3000

# Cambiar al usuario no-root para ejecutar la aplicación
USER nestjs

# Comando para ejecutar la aplicación usando el script de inicialización
CMD ["./scripts/init.sh"]
