# Usar una imagen base ligera de Node.js
FROM node:18-alpine

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo package.json
COPY package.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto de los archivos
COPY . .

# Exponer el puerto
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["node", "index.js"]
