# Terraform Doppler Configuration with Notes and Default Values

Este proyecto de Terraform gestiona proyectos Doppler con secrets que incluyen valores por defecto y notas descriptivas.

## 🚀 Características

- ✅ **Flexibilidad total**: Cada proyecto puede tener cualquier cantidad de secrets
- ✅ **Nombres personalizados**: Los nombres de secrets son completamente configurables
- ✅ **Valores por defecto**: Cada secret tiene un valor inicial seguro para development
- ✅ **Notas descriptivas**: Documentación clara de qué hace cada secret
- ✅ **Visibilidad configurable**: Control sobre si el secret es `masked` o `restricted`
- ✅ **Ignore changes**: Los valores pueden ser modificados manualmente sin conflictos
- ✅ **Estructura escalable**: Fácil agregar nuevos proyectos y secrets
- ✅ **Proyectos dinámicos**: Los proyectos se crean automáticamente desde la configuración

## 📊 Configuración Actual

El sistema está configurado con **5 proyectos** que demuestran la flexibilidad:

- **demo1**: 5 secrets (Backend API básico)
- **demo2**: 7 secrets (E-commerce con más integraciones)
- **demo3**: 4 secrets (Analytics minimalista)
- **demo4**: 6 secrets (Microservicio OAuth)
- **demo5**: 8 secrets (Payment Gateway completo)

**Total: 30 secrets** distribuidos de forma flexible según las necesidades de cada proyecto.

## 📁 Estructura del Proyecto

```
terraform-test-railway/
├── main.tf           # Configuración principal con recursos dinámicos
├── variables.tf      # Definición de variables con estructura compleja
├── outputs.tf        # Outputs informativos y documentación
├── terraform.tfvars  # Valores específicos con notas y defaults
└── README.md         # Esta documentación
```

## ⚙️ Configuración de Secrets

### Administración Centralizada

Todos los secrets se configuran en `terraform.tfvars`. El archivo `variables.tf` solo contiene ejemplos por defecto que puedes usar como plantilla.

### Estructura Básica

Cada secret se configura usando esta estructura:

```hcl
project_secrets = {
  nombre_proyecto = {
    NOMBRE_SECRET = {
      value      = "valor_del_secret"
      note       = "Descripción clara del propósito del secret"
      visibility = "masked"  # opcional: masked, restricted, unmasked
    }
  }
}
```

### Ejemplo Completo en terraform.tfvars

```hcl
project_secrets = {
  mi_api = {
    DATABASE_URL = {
      value = "postgresql://user:pass@localhost:5432/mi_db"
      note  = "URL de conexión a la base de datos principal"
    }
    API_KEY = {
      value      = "api_key_placeholder"
      note       = "Clave API para servicios externos"
      visibility = "restricted"  # Más seguro que "masked"
    }
    DEBUG_MODE = {
      value = "true"
      note  = "Habilitar modo debug en desarrollo"
    }
  }
  
  mi_frontend = {
    REACT_APP_API_URL = {
      value = "http://localhost:3001/api"
      note  = "URL del backend para el frontend React"
    }
    ANALYTICS_ID = {
      value = "GA-123456789"
      note  = "ID de Google Analytics"
    }
  }
}
```

### Características Importantes

1. **Nombres dinámicos**: Los nombres de proyectos se derivan automáticamente de las keys en `project_secrets`
2. **Secrets personalizables**: Cada proyecto puede tener cualquier combinación de secrets
3. **Configuración centralizada**: Todo se gestiona desde `terraform.tfvars`
4. **Valores por defecto**: `variables.tf` incluye ejemplos que puedes usar como plantilla

## 🛠️ Uso

### 1. Configurar el token de Doppler

```bash
export DOPPLER_TOKEN="tu_token_aqui"
```

### 2. Validar la configuración

```bash
terraform validate
```

### 3. Ver el plan de ejecución

```bash
terraform plan
```

### 4. Aplicar los cambios

```bash
terraform apply
```

### 5. Ver la documentación generada

```bash
terraform output secrets_documentation
```

## 📊 Outputs Disponibles

- `doppler_projects_created`: Lista de proyectos creados
- `doppler_secrets_created`: Secrets con sus notas (sin valores)
- `doppler_configuration_summary`: Resumen estadístico
- `secrets_documentation`: Documentación completa de secrets

## 🔒 Seguridad

- Los valores por defecto son solo para development
- Use `ignore_changes = [value]` para permitir cambios manuales
- Los valores sensibles no se muestran en outputs
- Configure `visibility = "restricted"` para secrets críticos

## 📝 Agregar Nuevos Proyectos y Secrets

### Agregar un Nuevo Proyecto

1. Edita `terraform.tfvars`
2. Agrega una nueva entrada en `project_secrets`:

```hcl
project_secrets = {
  # Proyectos existentes...
  
  nuevo_proyecto = {
    DATABASE_URL = {
      value = "postgresql://user:pass@localhost:5432/nuevo_db"
      note  = "Base de datos para el nuevo proyecto"
    }
    API_SECRET = {
      value      = "secret_key_here"
      note       = "Clave secreta del API"
      visibility = "restricted"
    }
  }
}
```

### Agregar Secrets a Proyecto Existente

1. Encuentra el proyecto en `terraform.tfvars`
2. Agrega el nuevo secret:

```hcl
project_secrets = {
  demo1 = {
    # Secrets existentes...
    
    NUEVO_SECRET = {
      value = "valor_inicial"
      note  = "Descripción del nuevo secret"
    }
  }
}
```

### Modificar Secrets Existentes

Simplemente actualiza los valores en `terraform.tfvars`:

```hcl
DATABASE_URL = {
  value = "postgresql://nuevo_host:5432/nueva_db"  # Nuevo valor
  note  = "Nueva descripción actualizada"
}
```

## 🔄 Lifecycle Management

- **ignore_changes**: Los valores pueden cambiarse manualmente en Doppler
- **prevent_destroy**: Los proyectos no se eliminan accidentalmente
- **create_before_destroy**: Actualizaciones seguras de recursos

## 🎯 Mejores Prácticas

1. **Notas descriptivas**: Siempre incluye una nota clara
2. **Valores seguros**: Usa placeholders en development
3. **Visibilidad apropiada**: `restricted` para secrets críticos
4. **Naming conventions**: Usa nombres descriptivos y consistentes
5. **Documentación**: Mantén el README actualizado

## 📈 Ejemplos de Proyectos

### Backend API (demo1)
- DATABASE_URL, API_KEY, JWT_SECRET, REDIS_URL, S3_BUCKET

### E-commerce (demo2) 
- DB_HOST, DB_USER, DB_PASS, EMAIL_API, STRIPE_KEY

### Analytics (demo3)
- MONGO_URI, AUTH_SECRET, WEBHOOK_URL, CDN_URL, LOG_LEVEL

### Auth Service (demo4)
- POSTGRES_URL, OAUTH_CLIENT, OAUTH_SECRET, CACHE_URL, DEBUG_MODE

### Payment Gateway (demo5)
- MYSQL_HOST, PAYMENT_KEY, SMS_API, BACKUP_URL, ENV_MODE
