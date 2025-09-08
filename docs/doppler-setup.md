# Configuración de Doppler

Esta guía te ayudará a configurar Doppler para la gestión de variables de entorno.

## 📋 Requisitos

- Cuenta en [Doppler](https://doppler.com/)
- CLI de Doppler instalado (opcional)

## 🔑 Obtener el token de Doppler

### Método 1: Desde la interfaz web

1. **Inicia sesión** en [Doppler](https://doppler.com/)
2. **Ve a "Access"** en el menú lateral
3. **Selecciona "Service Tokens"**
4. **Haz clic en "Generate"**
5. **Configura el token**:
   - **Name**: `terraform-token`
   - **Access**: `Read/Write`
   - **Scope**: `All Projects` o específico para el proyecto
6. **Copia el token** generado (formato: `dp.st.xxxxx`)

### Método 2: Usando Doppler CLI

```bash
# Instalar Doppler CLI
curl -Ls https://cli.doppler.com/install.sh | sh

# Iniciar sesión
doppler login

# Generar token
doppler configs tokens create terraform-token --plain
```

## ⚙️ Configurar el token en Terraform

### Opción 1: Variable de entorno
```bash
export DOPPLER_TOKEN="dp.st.tu_token_aqui"
```

### Opción 2: Archivo terraform.tfvars
```hcl
doppler_token = "dp.st.tu_token_aqui"
```

## 🏗️ Estructura que se creará en Doppler

```
Doppler
└── Proyecto: demo
    └── Environment: dev
        └── Config: dev
            ├── MONGODB_INTERNAL_URL
            ├── MONGODB_PUBLIC_URL
            └── DATABASE_URL
```

## 🔧 Variables de entorno configuradas

### MONGODB_INTERNAL_URL
- **Descripción**: URL para conexión interna desde Railway
- **Formato**: `mongodb://mongodb:27017`
- **Uso**: Conexiones desde otros servicios en Railway

### MONGODB_PUBLIC_URL
- **Descripción**: URL pública de MongoDB
- **Formato**: `mongodb://user:password@public-host:port`
- **Uso**: Conexiones externas o desde desarrollo local

### DATABASE_URL
- **Descripción**: URL completa con nombre de base de datos
- **Formato**: `mongodb://mongodb:27017/demo`
- **Uso**: Conexión directa a la base de datos específica

## 🔄 Integración con Railway

### Configuración automática
El proyecto de Terraform configurará automáticamente:

1. **Sincronización**: Variables de Doppler → Railway
2. **Actualización**: Cambios en Doppler se reflejan en Railway
3. **Seguridad**: Variables sensibles encriptadas

### Configuración manual (alternativa)

Si prefieres configurar manualmente:

1. **En Railway**:
   - Ve a tu servicio
   - Sección "Variables"
   - Conecta con Doppler

2. **En Doppler**:
   - Ve al proyecto `demo`
   - Environment `dev`
   - Config `dev`
   - Agrega las variables manualmente

## 🎯 Mejores prácticas

### Organización de secrets
```
# Estructura recomendada para secrets
DB_HOST=mongodb
DB_PORT=27017
DB_NAME=demo
DB_USER=admin
DB_PASSWORD=secure_password

# URLs compuestas
MONGODB_INTERNAL_URL=mongodb://${DB_HOST}:${DB_PORT}
DATABASE_URL=mongodb://${DB_HOST}:${DB_PORT}/${DB_NAME}
```

### Environments
- **dev**: Desarrollo local y staging
- **staging**: Entorno de pruebas
- **production**: Entorno de producción

### Configs por environment
- **dev**: Variables para desarrollo
- **staging**: Variables para pruebas
- **production**: Variables para producción

## 🔐 Seguridad

### Tokens
- ✅ Usa tokens con permisos mínimos necesarios
- ✅ Rota tokens regularmente
- ✅ No commitees tokens en el código
- ❌ No compartas tokens en mensajes/emails

### Variables sensibles
- ✅ Marca variables como "restricted" en Doppler
- ✅ Usa nombres descriptivos
- ✅ Documenta el propósito de cada variable
- ❌ No incluyas datos sensibles en logs

## 🐛 Troubleshooting

### Error: "Invalid token"
```bash
# Verificar formato del token
echo $DOPPLER_TOKEN
# Debe empezar con "dp.st."

# Regenerar token si es necesario
doppler configs tokens create terraform-token --plain
```

### Error: "Project not found"
```bash
# Verificar proyectos disponibles
doppler projects list

# Crear proyecto manualmente si es necesario
doppler projects create demo
```

### Error: "Environment not found"
```bash
# Verificar environments disponibles
doppler environments list --project demo

# Crear environment manualmente
doppler environments create dev --project demo
```

### Error: "Config not found"
```bash
# Verificar configs disponibles
doppler configs list --project demo

# Crear config manualmente
doppler configs create dev --project demo --environment dev
```

## 📱 CLI Commands útiles

```bash
# Listar proyectos
doppler projects list

# Listar environments
doppler environments list --project demo

# Listar configs
doppler configs list --project demo

# Ver secrets
doppler secrets list --project demo --config dev

# Agregar secret
doppler secrets set KEY=value --project demo --config dev

# Eliminar secret
doppler secrets delete KEY --project demo --config dev

# Ejecutar comando con variables de Doppler
doppler run --project demo --config dev -- npm start
```

## 📚 Referencias

- [Doppler Documentation](https://docs.doppler.com/)
- [Doppler CLI Reference](https://docs.doppler.com/docs/cli)
- [Doppler Terraform Provider](https://registry.terraform.io/providers/DopplerHQ/doppler/latest/docs)
