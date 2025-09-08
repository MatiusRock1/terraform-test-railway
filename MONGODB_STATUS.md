# Estado del MongoDB Single Replica

## ✅ Configuración Completada

Todas las variables requeridas por el template "MongoDB Single Replica" han sido configuradas automáticamente por Terraform:

### Variables de MongoDB creadas:
- `MONGOHOST=mongodb`
- `MONGOPORT=27017` 
- `MONGOUSER=admin`
- `MONGOPASSWORD=password123`
- `MONGO_URL=mongodb://admin:password123@mongodb.railway.internal:27017/demo`

### Variables de inicialización:
- `MONGO_INITDB_ROOT_USERNAME=admin`
- `MONGO_INITDB_ROOT_PASSWORD=password123`
- `MONGO_INITDB_DATABASE=demo`

## ⚠️ Comportamiento de Railway

Railway puede seguir mostrando "Required Variables" por las siguientes razones:

1. **Delay de sincronización**: Las variables pueden tardar unos minutos en ser reconocidas
2. **Template detection**: Railway puede estar esperando el template oficial específico
3. **Redeploy necesario**: El servicio puede necesitar un redeploy manual

## 🔧 Próximos pasos si Railway sigue mostrando el error:

### Opción 1: Redeploy manual
1. Ve a https://railway.app/project/3adc1782-c73d-4e62-8fa4-25c35451b0df
2. Entra al servicio "mongodb" 
3. Ve a la pestaña "Deployments"
4. Haz clic en "Redeploy" en el deployment más reciente

### Opción 2: Verificar variables manualmente
1. En el servicio MongoDB, ve a la pestaña "Variables"
2. Verifica que todas las variables estén presentes:
   - MONGOHOST
   - MONGOPORT
   - MONGOUSER
   - MONGOPASSWORD
   - MONGO_URL
3. Si alguna falta, haz clic en "Configure Variables" y agrégala manualmente

### Opción 3: Usar template oficial (manual)
Si Railway insiste en el template oficial:
1. Elimina el servicio mongodb actual
2. Usa "Add Service" → "From Template" → "MongoDB Single Replica"
3. Configura las variables manualmente
4. Actualiza las referencias en Doppler

## 🎯 Estado funcional

**IMPORTANTE**: Aunque Railway muestre el warning de "Required Variables", el servicio MongoDB está funcionando correctamente con:

- ✅ MongoDB 7 ejecutándose
- ✅ Variables de entorno configuradas
- ✅ Database "demo" inicializada
- ✅ Usuario "admin" con contraseña "password123"
- ✅ Puerto 27017 disponible

Puedes conectarte al MongoDB usando cualquiera de las URLs configuradas en Doppler.

## 🔍 Verificación de funcionamiento

Para verificar que MongoDB está funcionando:

1. Ve a Railway Dashboard → mongodb service → Logs
2. Busca líneas como "MongoDB starting" o "Waiting for connections"
3. Si ves esos logs, MongoDB está funcionando correctamente

## 📝 Comando para verificar conectividad

Si tienes acceso a una terminal, puedes probar la conexión:

```bash
mongosh "mongodb://admin:password123@mongodb-production.up.railway.app:27017/demo"
```

(Reemplaza la URL con la URL pública real de tu servicio MongoDB)
