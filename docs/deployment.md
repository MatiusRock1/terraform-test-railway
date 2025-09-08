# Guía de Despliegue

Esta guía te llevará paso a paso por el proceso completo de despliegue del proyecto.

## 🚀 Despliegue paso a paso

### 1. Prerrequisitos

Antes de comenzar, asegúrate de tener:

- ✅ [Terraform instalado](https://www.terraform.io/downloads.html)
- ✅ Token de Railway configurado
- ✅ Token de Doppler configurado
- ✅ Git instalado
- ✅ Acceso al repositorio

### 2. Clonar y configurar

```bash
# Clonar el repositorio
git clone https://github.com/MatiusRock1/terraform-test-railway.git
cd terraform-test-railway

# Copiar archivo de variables
cp terraform.tfvars.example terraform.tfvars

# Editar variables con tus tokens
nano terraform.tfvars
```

**Contenido de terraform.tfvars:**
```hcl
railway_token = "tu_railway_token_real"
doppler_token = "dp.st.tu_doppler_token_real"
git_repo      = "https://github.com/MatiusRock1/terraform-test-railway"
project_name  = "demo"
environment   = "dev"
```

### 3. Inicializar Terraform

```bash
# Inicializar Terraform
terraform init

# Verificar configuración
terraform validate

# Ver plan de ejecución
terraform plan
```

**Salida esperada:**
```
Plan: 7 to add, 0 to change, 0 to destroy.
```

### 4. Aplicar configuración

```bash
# Aplicar cambios
terraform apply

# Confirmar con 'yes' cuando se solicite
```

**Recursos que se crearán:**
- 1 proyecto en Railway
- 2 servicios en Railway (MongoDB + Hello World App con imagen Docker)
- 1 proyecto en Doppler
- 1 environment en Doppler
- 1 config en Doppler
- 3 secrets en Doppler

### 5. Verificar despliegue

```bash
# Ver outputs
terraform output

# Ver estado actual
terraform show
```

## 🔍 Verificación del despliegue

### Railway Dashboard

1. **Ir a Railway**: https://railway.app/
2. **Verificar proyecto "demo"** en tu dashboard
3. **Revisar servicios**:
   - `mongodb`: Debe estar en estado "Active"
   - `hello-world-app`: Debe estar en estado "Active"

### Doppler Dashboard

1. **Ir a Doppler**: https://doppler.com/
2. **Verificar proyecto "demo"**
3. **Revisar environment "dev"**
4. **Verificar config "dev"** con 3 secrets:
   - `MONGODB_INTERNAL_URL`
   - `MONGODB_PUBLIC_URL`
   - `DATABASE_URL`

### Aplicación funcionando

```bash
# Obtener URL de la aplicación
terraform output app_service_url

# Probar endpoint (reemplaza con tu URL real)
curl https://tu-app.railway.app/

# La aplicación testcontainers/helloworld responde con una página simple
```

## 🔄 Actualización del proyecto

### Cambios en el código

Como ahora usamos una imagen Docker precompilada (`testcontainers/helloworld`), no necesitas hacer cambios en el código de la aplicación. Si quisieras cambiar la imagen:

```bash
# Modificar main.tf para usar otra imagen
source = {
  image = "otra-imagen:tag"
}

# Aplicar cambios
terraform apply
```

### Cambios en la infraestructura

```bash
# Modificar archivos .tf
# Planificar cambios
terraform plan

# Aplicar cambios
terraform apply
```

### Actualizar variables de entorno

```bash
# Opción 1: Via Terraform (recomendado)
# Modificar main.tf y aplicar
terraform apply

# Opción 2: Via Doppler CLI
doppler secrets set NEW_VAR=value --project demo --config dev

# Opción 3: Via Doppler Dashboard
# Ir a Doppler > demo > dev > Agregar secret
```

## 🗑️ Limpieza y destrucción

### Destruir infraestructura

```bash
# Ver qué se eliminará
terraform plan -destroy

# Eliminar todos los recursos
terraform destroy

# Confirmar con 'yes'
```

### Limpieza manual (si es necesario)

Si algunos recursos no se eliminan automáticamente:

**Railway:**
1. Ir al dashboard de Railway
2. Eliminar proyecto "demo" manualmente

**Doppler:**
1. Ir al dashboard de Doppler
2. Eliminar proyecto "demo" manualmente

## 🚨 Troubleshooting de despliegue

### Error: Provider not found

```bash
# Error común con providers
Error: Failed to query available provider packages

# Solución
rm -rf .terraform
terraform init
```

### Error: Invalid token

```bash
# Verificar tokens
echo $RAILWAY_TOKEN
echo $DOPPLER_TOKEN

# O verificar terraform.tfvars
cat terraform.tfvars
```

### Error: Resource already exists

```bash
# Si el recurso ya existe, importarlo
terraform import railway_project.demo project-id-existente

# O usar otro nombre
# Modificar variables.tf: project_name = "demo2"
```

### Error: MongoDB template not found

```bash
# Verificar templates disponibles en Railway
# O usar configuración manual de MongoDB

# Alternativa en main.tf:
resource "railway_service" "mongodb" {
  name       = "mongodb"
  project_id = railway_project.demo.id
  
  # En lugar de template, usar imagen
  source = {
    image = "mongo:6.0"
  }
}
```

### App no despliega correctamente

```bash
# Verificar logs en Railway dashboard
# O verificar Dockerfile y package.json

# Verificar que el repositorio sea público
# O configurar acceso correcto al repositorio privado
```

## 🔄 Rollback

### Rollback de Terraform

```bash
# Ver historial de estados
terraform state list

# Restaurar estado anterior (si tienes backup)
cp terraform.tfstate.backup terraform.tfstate
terraform refresh
```

### Rollback de aplicación

```bash
# En Railway dashboard
# 1. Ir a tu servicio
# 2. Sección "Deployments"
# 3. Hacer clic en "Rollback" en el deployment anterior
```

## 📊 Monitoreo post-despliegue

### Logs de aplicación

```bash
# Railway CLI
railway login
railway logs --service hello-world-app

# O via dashboard web
```

### Métricas de MongoDB

```bash
# Conectarse a MongoDB y verificar
railway connect mongodb

# O via dashboard de Railway > MongoDB service > Metrics
```

### Variables de entorno

```bash
# Como usamos la imagen testcontainers/helloworld,
# esta aplicación no consume las variables de MongoDB,
# pero las variables siguen configurándose en Doppler

# Verificar variables en Doppler
doppler secrets list --project demo --config dev
```

## 📚 Siguientes pasos

Después del despliegue exitoso:

1. **Configurar dominio personalizado** en Railway
2. **Añadir más variables de entorno** según necesites
3. **Configurar CI/CD** para automatizar despliegues
4. **Implementar logging** y monitoreo adicional
5. **Configurar backups** de MongoDB
6. **Configurar environments adicionales** (staging, production)
