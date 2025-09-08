# Railway MongoDB Single Replica with Terraform

Este proyecto despliega un MongoDB Single Replica Set en Railway usando Terraform, con integración a Doppler para manejo de secretos.

## 🏗️ Arquitectura

- **MongoDB**: Single Replica Set con Bitnami MongoDB 7.0
- **Railway**: Plataforma de despliegue cloud
- **Terraform**: Infraestructura como código
- **Doppler**: Manejo de secretos y variables de entorno
- **TCP Proxy**: Acceso público a MongoDB

## 📁 Estructura del Proyecto

```
terraform-test-railway/
├── main.tf              # Configuración principal de Terraform
├── dev2-variables.tf    # Variables específicas para el entorno "dev 2"
├── variables.tf         # Definición de variables
├── outputs.tf           # Outputs de Terraform
├── terraform.tfvars     # Valores de variables (local)
└── README.md           # Este archivo
```

## 🚀 Características

### MongoDB
- ✅ Single Replica Set configurado
- ✅ Autenticación habilitada
- ✅ Usuario admin configurado
- ✅ Base de datos `demo` creada
- ✅ Keyfile para autenticación del replica set

### Railway
- ✅ TCP Proxy para acceso público
- ✅ Variables de entorno configuradas
- ✅ Servicio Hello World incluido

### Doppler
- ✅ Proyecto y entorno configurados
- ✅ Secretos sincronizados automáticamente

## 🔧 Configuración

### Variables de MongoDB
- **Usuario**: `admin`
- **Contraseña**: `password123`
- **Base de datos**: `demo`
- **Replica Set**: `rs0`

### Acceso Público
- **Dominio**: `shinkansen.proxy.rlwy.net:17461`
- **URL**: `mongodb://admin:password123@shinkansen.proxy.rlwy.net:17461/demo?authSource=admin`

## 📋 Uso

### 1. Desplegar con Terraform
```bash
terraform init
terraform plan
terraform apply
```

### 2. Conectar con MongoDB Compass
```
mongodb://admin:password123@shinkansen.proxy.rlwy.net:17461/demo?authSource=admin
```

### 3. Conectar con mongosh
```bash
mongosh "mongodb://admin:password123@shinkansen.proxy.rlwy.net:17461/demo?authSource=admin"
```

### 4. Verificar Replica Set
```javascript
rs.status()
rs.conf()
```

## 🎯 Outputs Disponibles

- `mongodb_public_url`: URL completa de conexión
- `mongodb_public_domain`: Dominio y puerto público
- `mongodb_internal_url`: URL interna para Railway
- `app_service_id`: ID del servicio Hello World

## ⚙️ Requisitos

- Terraform >= 1.0
- Railway CLI
- Doppler CLI
- Cuenta en Railway
- Cuenta en Doppler

## 🔒 Seguridad

- Las credenciales están configuradas en Doppler
- El replica set usa keyfile para autenticación
- Acceso público controlado por Railway TCP Proxy

## 📝 Notas

- El proyecto usa el entorno "dev 2" existente en Railway
- Las variables están separadas en `dev2-variables.tf` para mayor claridad
- El replica set está configurado como PRIMARY con un solo nodo

## 🎉 Estado

✅ **Proyecto completamente funcional**
- MongoDB desplegado y funcionando
- Replica set configurado correctamente
- Acceso público habilitado
- Operaciones CRUD funcionando
