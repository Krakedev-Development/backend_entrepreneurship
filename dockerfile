# --- Etapa 1: Builder ---
# Usamos una imagen completa de Node.js para instalar dependencias y construir la aplicación.
FROM node:20-alpine AS builder

# Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

COPY package*.json ./

# Instalamos todas las dependencias (incluyendo devDependencies para la compilación)
RUN npm install

COPY . .

# Generamos el cliente de Prisma (esencial)
RUN npx prisma generate

RUN npm run build

RUN npm prune --production

# Usamos una imagen ligera de Node.js para la ejecución, resultando en una imagen final pequeña.
FROM node:20-alpine

# Establecemos el directorio de trabajo
WORKDIR /usr/src/app
#Copiamos los archivos necesarios
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/prisma ./prisma
# Exponemos el puerto en el que la aplicación NestJS se ejecuta por defecto
EXPOSE 3000

CMD ["node", "dist/main"]