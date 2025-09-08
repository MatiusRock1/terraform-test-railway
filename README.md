# Proyecto Terraform - Railway + Doppler + MongoDB

Este proyecto utiliza Terraform para automatizar la creación y configuración de infraestructura en Railway y Doppler, incluyendo:

- ✅ Proyecto en Railway con un servicio MongoDB (template Single Replica)
- ✅ Servicio Hello World usando imagen Docker `testcontainers/helloworld`
- ✅ Proyecto en Doppler para gestión de variables de entorno
- ✅ Configuración automática de URLs de conexión a MongoDB

## ⚠️ Requisitos importantes

### Railway Plan
**IMPORTANTE**: Railway requiere un plan de pago para crear proyectos y servicios. Si tu trial ha expirado:

1. Ve a [Railway Dashboard → Settings → Billing](https://railway.app/account/billing)
2. Selecciona un plan (Hobby plan es $5/mes)
3. Agrega un método de pago

Sin un plan activo, verás errores como "Your trial has expired" al ejecutar Terraform.

### Tokens requeridos

- **Railway Token**: Crear en [Railway Dashboard → Settings → Tokens](https://railway.app/account/tokens) con permisos "Full Access"
- **Doppler Token**: Crear en [Doppler Dashboard → Access → Service Tokens](https://dashboard.doppler.com/)

## 🚀 Configuración rápida

### 1. Clonar el repositorio
```bash
git clone https://github.com/MatiusRock1/terraform-test-railway.git
cd terraform-test-railway
```

### 2. Configurar variables
```bash
# Copiar el archivo de ejemplo
cp terraform.tfvars.example terraform.tfvars

# Editar con tus tokens reales
nano terraform.tfvars
```

### 3. Inicializar Terraform
```bash
terraform init
```

### 4. Revisar el plan
```bash
terraform plan
```

### 5. Aplicar la configuración
```bash
terraform apply
```

## 📁 Estructura del proyecto

```
terraform-test-railway/
├── main.tf                    # Configuración principal de Terraform
├── variables.tf               # Definición de variables
├── outputs.tf                 # Outputs del proyecto
├── terraform.tfvars.example   # Ejemplo de variables
├── railway.json               # Configuración de Railway (opcional)
├── setup.sh                   # Script de configuración automática
├── .gitignore                 # Archivos ignorados por Git
├── README.md                  # Este archivo
└── docs/                      # Documentación detallada
    ├── railway-setup.md       # Configuración de Railway
    ├── doppler-setup.md       # Configuración de Doppler
    ├── troubleshooting.md     # Solución de problemas
    └── deployment.md          # Guía de despliegue
```

## 🔧 Configuración post-despliegue

⚠️ **IMPORTANTE**: Después de ejecutar `terraform apply`, necesitas configurar manualmente los servicios en Railway:

1. **MongoDB**: Configurar con template "MongoDB Single Replica" desde Railway Dashboard
2. **Hello World**: Configurar con imagen `testcontainers/helloworld:latest`

Ver [RAILWAY_SETUP.md](./RAILWAY_SETUP.md) para instrucciones detalladas.

## 🔧 Recursos creados

### ✅ Railway (COMPLETADO)
- **Proyecto**: `Demo Jorge TP`
- **Servicio MongoDB**: ✅ Configurado con imagen `mongo:7` y todas las variables del template Single Replica
- **Servicio Hello World**: ✅ Configurado con imagen `testcontainers/helloworld:latest`
- **Variables**: ✅ Todas las variables de MongoDB configuradas automáticamente

### ✅ Doppler (COMPLETADO)
- **Proyecto**: `demo`
- **Environment**: `dev` 
- **Config**: `dev_backend`
- **Secrets configurados**:
  - `MONGODB_INTERNAL_URL`: ✅ URL interna de conexión
  - `MONGODB_PUBLIC_URL`: ✅ URL Railway de conexión  
  - `DATABASE_URL`: ✅ URL completa de la base de datos

### 📊 Variables de MongoDB configuradas

| Variable | Valor | Descripción |
|----------|-------|-------------|
| `MONGOHOST` | `mongodb` | Hostname interno |
| `MONGOPORT` | `27017` | Puerto de MongoDB |
| `MONGOUSER` | `admin` | Usuario administrador |
| `MONGOPASSWORD` | `password123` | Contraseña |
| `MONGO_URL` | `mongodb://admin:password123@mongodb.railway.internal:27017/demo` | URL completa |
| `MONGO_INITDB_DATABASE` | `demo` | Base de datos inicial |

⚠️ **NOTA**: Railway puede mostrar "Required Variables" aunque estén configuradas. Ver `MONGODB_STATUS.md` para detalles.

## 📊 Variables de entorno configuradas

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `MONGODB_INTERNAL_URL` | URL interna para conexión desde Railway | `mongodb://mongodb:27017` |
| `MONGODB_PUBLIC_URL` | URL pública de MongoDB | `mongodb://user:pass@host:port` |
| `DATABASE_URL` | URL completa con nombre de BD | `mongodb://mongodb:27017/demo` |

## 🌐 Endpoints de la aplicación

Una vez desplegada, la aplicación Hello World (testcontainers/helloworld) expone un endpoint simple:

- `GET /` - Página Hello World básica

> **Nota**: Esta imagen Docker es una aplicación de prueba simple que responde en el puerto 8080.

## 📚 Documentación detallada

- [Configuración de Railway](./docs/railway-setup.md)
- [Configuración de Doppler](./docs/doppler-setup.md)
- [Guía de despliegue](./docs/deployment.md)
- [Configuración post-despliegue Railway](./RAILWAY_SETUP.md) ⭐ **IMPORTANTE**
- [Personalización de la aplicación](./docs/customization.md)
- [Solución de problemas](./docs/troubleshooting.md)

## 🔒 Seguridad

⚠️ **IMPORTANTE**: Nunca commitees los archivos `terraform.tfvars` o `.env` que contengan tokens o credenciales reales.

## 🤝 Contribución

1. Fork el proyecto
2. Crea tu rama de features (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.
