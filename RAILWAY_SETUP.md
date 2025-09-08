# Configuración post-despliegue de Railway

Después de ejecutar `terraform apply`, necesitas configurar manualmente los servicios en Railway Dashboard.

## 🗄️ Configurar MongoDB con Template

### 1. Ir al Dashboard de Railway
- Ve a https://railway.app/
- Busca tu proyecto "demo"
- Entra al proyecto

### 2. Configurar el servicio MongoDB
1. **Haz clic en el servicio "mongodb"**
2. **Ve a la pestaña "Deploy"**
3. **Selecciona "Deploy from Template"**
4. **Busca "MongoDB Single Replica"** en la galería de templates
5. **Selecciona el template "MongoDB Single Replica"** (la versión más reciente disponible)
6. **Configura las variables de entorno** según el template:
   ```
   MONGO_INITDB_DATABASE=demo
   MONGO_INITDB_ROOT_USERNAME=admin
   MONGO_INITDB_ROOT_PASSWORD=password123
   ```
7. **Haz clic en "Deploy"**

> **Nota**: La plantilla "MongoDB Single Replica" es ideal para desarrollo y aplicaciones que no requieren alta disponibilidad. Proporciona una instancia MongoDB completa y funcional.

### 3. Configurar el servicio Hello World
1. **Haz clic en el servicio "hello-world-app"**
2. **Ve a la pestaña "Deploy"**
3. **Selecciona "Deploy from Docker Image"**
4. **Ingresa la imagen**: `testcontainers/helloworld:latest`
5. **Configura variables de entorno**:
   ```
   PORT=8080
   ```
6. **Haz clic en "Deploy"**

### 4. Conectar variables de entorno de Doppler
1. **En cada servicio, ve a "Variables"**
2. **Conecta con Doppler**:
   - Project: `demo`
   - Environment: `dev`
   - Config: `dev`

### 5. Obtener URLs públicas
1. **Para cada servicio, ve a "Settings"**
2. **En la sección "Networking"**
3. **Genera una URL pública** si no está generada automáticamente
4. **Actualiza las variables en Doppler** con las URLs reales:
   - `MONGODB_PUBLIC_URL`: La URL pública de MongoDB
   - `MONGODB_INTERNAL_URL`: `mongodb://mongodb:27017` (ya configurada)

## 🔧 Variables finales en Doppler

Después de la configuración, deberías tener en Doppler:

```
MONGODB_INTERNAL_URL=mongodb://mongodb:27017
MONGODB_PUBLIC_URL=mongodb://admin:password123@mongodb-production-xxxx.up.railway.app:xxxxx
DATABASE_URL=mongodb://mongodb:27017/demo
```

## ✅ Verificación

1. **Verificar que MongoDB esté ejecutándose**:
   - En Railway Dashboard → mongodb service → Logs
   - Deberías ver logs de MongoDB iniciándose

2. **Verificar que Hello World esté ejecutándose**:
   - En Railway Dashboard → hello-world-app service → Logs
   - Visitar la URL pública del servicio

3. **Verificar variables en Doppler**:
   - Ve a Doppler Dashboard → demo → dev
   - Todas las variables deben estar configuradas

## 🚨 Troubleshooting

### MongoDB no inicia
- Verificar que seleccionaste el template "MongoDB Single Replica" exactamente
- Revisar logs para errores de configuración
- Asegurarte de que las variables de entorno estén correctas
- Verificar que el template esté disponible en tu región

### Hello World no responde
- Verificar que la imagen `testcontainers/helloworld:latest` se descargó correctamente
- Verificar que el puerto 8080 esté configurado
- Revisar logs del servicio

### Variables de Doppler no se conectan
- Verificar que el proyecto y environment en Doppler coincidan
- Verificar que la integración de Doppler esté habilitada en Railway
- Reconectar la integración si es necesario
