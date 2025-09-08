# Configuración de Railway

Esta guía te ayudará a configurar Railway para usar con Terraform.

## 📋 Requisitos

- Cuenta en [Railway](https://railway.app/)
- CLI de Railway instalado (opcional)

## 🔑 Obtener el token de Railway

### Método 1: Desde la interfaz web

1. **Inicia sesión** en [Railway](https://railway.app/)
2. **Ve a tu perfil** haciendo clic en tu avatar (esquina superior derecha)
3. **Selecciona "Account Settings"**
4. **Ve a la sección "Tokens"**
5. **Haz clic en "New Token"**
6. **Dale un nombre** al token (ej: "terraform-token")
7. **Selecciona los permisos** necesarios:
   - `projects:read`
   - `projects:write`
   - `services:read`
   - `services:write`
   - `environments:read`
   - `environments:write`
8. **Copia el token** generado

### Método 2: Usando Railway CLI

```bash
# Instalar Railway CLI
npm install -g @railway/cli

# Iniciar sesión
railway login

# Generar token
railway tokens create
```

## ⚙️ Configurar el token en Terraform

### Opción 1: Variable de entorno
```bash
export RAILWAY_TOKEN="tu_token_aqui"
```

### Opción 2: Archivo terraform.tfvars
```hcl
railway_token = "tu_token_aqui"
```

## 🏗️ Recursos que se crearán

### Proyecto Railway
- **Nombre**: `demo`
- **Descripción**: Proyecto creado automáticamente por Terraform

### Servicios
1. **MongoDB Service**
   - **Template**: MongoDB Single Replica
   - **Configuración**: Base de datos en blanco con una sola réplica
   - **Puerto interno**: 27017

2. **Hello World App**
   - **Tipo**: Git deployment
   - **Dockerfile**: Incluido en el repositorio
   - **Puerto**: 3000

## 🔗 URLs importantes

Después del despliegue, tendrás acceso a:

- **Dashboard del proyecto**: `https://railway.app/project/{project-id}`
- **Logs de MongoDB**: Disponibles en el dashboard
- **Logs de la aplicación**: Disponibles en el dashboard
- **URL pública de la app**: Se genera automáticamente

## 🐛 Troubleshooting

### Error: "Invalid token"
- Verifica que el token esté correctamente copiado
- Asegúrate de que el token tenga los permisos necesarios
- Regenera el token si es necesario

### Error: "Project already exists"
- Cambia el nombre del proyecto en `variables.tf`
- O elimina el proyecto existente desde Railway dashboard

### Error: "Template not found"
- Verifica que el template "MongoDB Single Replica" esté disponible
- Busca en la galería de templates de Railway con el nombre exacto
- Consulta la documentación de Railway para templates actualizados
- Verifica que tu cuenta tenga acceso a templates de la comunidad

## 📚 Referencias

- [Railway Documentation](https://docs.railway.app/)
- [Railway API Reference](https://docs.railway.app/reference/api-reference)
- [Railway Templates](https://railway.app/templates)
