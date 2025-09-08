# Solución de Problemas

Esta guía te ayudará a resolver los problemas más comunes que puedes encontrar.

## 🚨 Problemas comunes de Terraform

### Error: "terraform: command not found"

**Problema**: Terraform no está instalado o no está en el PATH.

**Solución**:
```bash
# macOS con Homebrew
brew install terraform

# Linux
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Verificar instalación
terraform --version
```

### Error: "Provider registry.terraform.io/terraform-community-providers/railway does not exist"

**Problema**: El provider de Railway ha cambiado o no está disponible.

**Solución**:
```bash
# Limpiar cache de providers
rm -rf .terraform .terraform.lock.hcl

# Verificar providers disponibles
terraform providers

# Alternativa: usar provider diferente
# En main.tf, cambiar a:
railway = {
  source  = "terraform-community-providers/railway"
  version = "~> 0.2.0"  # versión anterior
}
```

### Error: "Invalid provider configuration"

**Problema**: Tokens mal configurados o inválidos.

**Solución**:
```bash
# Verificar variables
echo $RAILWAY_TOKEN
echo $DOPPLER_TOKEN

# Verificar formato del token de Doppler
# Debe empezar con "dp.st."

# Regenerar tokens si es necesario
```

## 🚂 Problemas con Railway

### Error: "Authentication failed"

**Problema**: Token de Railway inválido o expirado.

**Solución**:
```bash
# Regenerar token en Railway
# 1. Ir a Railway Dashboard
# 2. Account Settings > Tokens
# 3. Crear nuevo token
# 4. Actualizar terraform.tfvars

# Verificar permisos del token
# Debe tener: projects:write, services:write
```

### Error: "Project name already exists"

**Problema**: Ya existe un proyecto con el mismo nombre.

**Solución**:
```bash
# Opción 1: Cambiar nombre del proyecto
# En variables.tf:
variable "project_name" {
  default = "demo-terraform-$(date +%s)"
}

# Opción 2: Eliminar proyecto existente
# Desde Railway Dashboard

# Opción 3: Importar proyecto existente
terraform import railway_project.demo PROJECT_ID
```

### Error: "Template 'mongodb-single-replica' not found"

**Problema**: El template de MongoDB no está disponible.

**Solución**:
```bash
# Verificar templates disponibles en Railway

# Alternativa: usar imagen de Docker directamente
# En main.tf:
resource "railway_service" "mongodb" {
  name       = "mongodb"
  project_id = railway_project.demo.id
  
  source = {
    image = "mongo:6.0"
  }
  
  variables = {
    MONGO_INITDB_DATABASE = "demo"
  }
}
```

### Error: "Service deployment failed"

**Problema**: La aplicación no se despliega correctamente.

**Solución**:
```bash
# Verificar logs en Railway dashboard
# Railway > Proyecto > Servicio > Logs

# Problemas comunes:
# 1. Dockerfile incorrecto
# 2. package.json faltante
# 3. Puerto no expuesto correctamente

# Verificar Dockerfile:
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]

# Verificar que la app escuche en 0.0.0.0
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
```

## 🔐 Problemas con Doppler

### Error: "Invalid Doppler token"

**Problema**: Token mal formateado o inválido.

**Solución**:
```bash
# Verificar formato del token
echo $DOPPLER_TOKEN
# Debe empezar con "dp.st."

# Regenerar token
doppler configs tokens create terraform --plain

# O desde Doppler Dashboard:
# Access > Service Tokens > Generate
```

### Error: "Project not found"

**Problema**: El proyecto no existe en Doppler.

**Solución**:
```bash
# Crear proyecto manualmente
doppler projects create demo

# O desde Doppler Dashboard:
# Projects > New Project
```

### Error: "Environment not found"

**Problema**: El environment no existe.

**Solución**:
```bash
# Crear environment
doppler environments create dev --project demo

# Verificar environments existentes
doppler environments list --project demo
```

### Error: "Insufficient permissions"

**Problema**: El token no tiene permisos suficientes.

**Solución**:
```bash
# Generar nuevo token con permisos completos
# En Doppler Dashboard:
# 1. Access > Service Tokens
# 2. Generate token
# 3. Scope: All Projects
# 4. Access: Read/Write
```

## 🐳 Problemas con Docker/Aplicación

### Error: "Port already in use"

**Problema**: El puerto 3000 está siendo usado.

**Solución**:
```bash
# Verificar qué usa el puerto
lsof -i :3000

# Cambiar puerto en index.js
const PORT = process.env.PORT || 8080;

# O matar el proceso que usa el puerto
kill -9 PID
```

### Error: "Cannot find module 'express'"

**Problema**: Dependencias no instaladas.

**Solución**:
```bash
# Instalar dependencias localmente
npm install

# Verificar package.json
cat package.json

# Verificar que Dockerfile instale dependencias
RUN npm install
```

### Error: "Application crashes immediately"

**Problema**: Error en el código de la aplicación.

**Solución**:
```bash
# Ejecutar localmente para debug
node index.js

# Verificar logs de Railway
# Dashboard > Service > Logs

# Agregar más logging
console.log('Starting server...');
console.log('Environment:', process.env.NODE_ENV);
```

## 🌐 Problemas de conectividad

### Error: "Cannot connect to MongoDB"

**Problema**: Variables de conexión mal configuradas.

**Solución**:
```bash
# Verificar variables en Doppler
doppler secrets list --project demo --config dev

# Verificar en la aplicación
curl https://tu-app.railway.app/db-config

# Verificar formato de URL
# Interno: mongodb://mongodb:27017
# Público: mongodb://user:pass@host:port/db
```

### Error: "Service not accessible externally"

**Problema**: El servicio no está expuesto correctamente.

**Solución**:
```bash
# Verificar que Railway esté generando URL pública
# Dashboard > Service > Settings > Public URL

# Verificar que la app escuche en 0.0.0.0
app.listen(PORT, '0.0.0.0', () => {
  // ...
});

# No usar localhost o 127.0.0.1
```

## 📋 Problemas de permisos

### Error: "Permission denied"

**Problema**: Permisos insuficientes en el sistema.

**Solución**:
```bash
# Para archivos de configuración
chmod 600 terraform.tfvars
chmod 644 *.tf

# Para directorios
chmod 755 docs/

# Para ejecutables
chmod +x scripts/*
```

### Error: "Git authentication failed"

**Problema**: No se puede acceder al repositorio.

**Solución**:
```bash
# Verificar acceso al repositorio
git clone https://github.com/MatiusRock1/terraform-test-railway.git

# Si el repo es privado, configurar SSH keys o tokens
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# Usar SSH en lugar de HTTPS
git remote set-url origin git@github.com:MatiusRock1/terraform-test-railway.git
```

## 🔧 Comandos de diagnóstico útiles

### Verificar estado de Terraform

```bash
# Ver estado actual
terraform show

# Ver recursos creados
terraform state list

# Verificar configuración
terraform validate

# Ver plan sin aplicar
terraform plan

# Refrescar estado
terraform refresh
```

### Verificar conectividad

```bash
# Probar conexión a APIs
curl -H "Authorization: Bearer $RAILWAY_TOKEN" https://backboard.railway.app/graphql
curl -H "Authorization: Bearer $DOPPLER_TOKEN" https://api.doppler.com/v3/projects

# Probar aplicación
curl https://tu-app.railway.app/health
```

### Logs y debugging

```bash
# Logs detallados de Terraform
TF_LOG=DEBUG terraform apply

# Ver outputs detallados
terraform output -json

# Verificar variables
terraform console
> var.railway_token
> var.doppler_token
```

## 📞 Obtener ayuda adicional

### Recursos oficiales

- [Terraform Documentation](https://www.terraform.io/docs)
- [Railway Documentation](https://docs.railway.app/)
- [Doppler Documentation](https://docs.doppler.com/)

### Comunidad

- [Railway Discord](https://discord.gg/railway)
- [Terraform Community](https://discuss.hashicorp.com/c/terraform-core/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/terraform)

### Logs para soporte

Si necesitas abrir un ticket de soporte, incluye:

```bash
# Versión de Terraform
terraform --version

# Logs con debug
TF_LOG=DEBUG terraform apply 2>&1 | tee terraform-debug.log

# Estado actual
terraform show

# Configuración (sin tokens)
cat main.tf variables.tf outputs.tf
```

## 🔄 Reset completo

Si todo falla, puedes hacer un reset completo:

```bash
# 1. Limpiar estado de Terraform
rm -rf .terraform terraform.tfstate* .terraform.lock.hcl

# 2. Eliminar recursos manualmente
# Railway Dashboard > Eliminar proyecto
# Doppler Dashboard > Eliminar proyecto

# 3. Reinicializar
terraform init
terraform plan
terraform apply
```
