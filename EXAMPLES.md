# Ejemplos Avanzados de Configuración

## 🔧 Configuración Flexible por Proyecto

### Proyecto Minimalista (2 secrets)
```hcl
minimal_service = {
  PORT = {
    value = "3000"
    note  = "Puerto donde corre el servicio"
  }
  NODE_ENV = {
    value = "development"
    note  = "Entorno de Node.js"
  }
}
```

### Proyecto Complejo (12+ secrets)
```hcl
enterprise_app = {
  # Base de datos principal
  PRIMARY_DB_URL = {
    value      = "postgresql://user:pass@primary-db:5432/enterprise"
    note       = "Base de datos principal"
    visibility = "restricted"
  }
  
  # Base de datos de lectura
  REPLICA_DB_URL = {
    value = "postgresql://user:pass@replica-db:5432/enterprise"
    note  = "Base de datos de solo lectura"
  }
  
  # Cache distribuido
  REDIS_CLUSTER_URLS = {
    value = "redis://redis-1:6379,redis://redis-2:6379,redis://redis-3:6379"
    note  = "URLs del cluster de Redis"
  }
  
  # Servicios externos
  STRIPE_SECRET_KEY = {
    value      = "sk_live_stripe_key"
    note       = "Clave secreta de Stripe para producción"
    visibility = "restricted"
  }
  
  SENDGRID_API_KEY = {
    value      = "sendgrid_api_key"
    note       = "API key de SendGrid para emails"
    visibility = "restricted"
  }
  
  TWILIO_AUTH_TOKEN = {
    value      = "twilio_auth_token"
    note       = "Token de autenticación de Twilio"
    visibility = "restricted"
  }
  
  AWS_ACCESS_KEY_ID = {
    value = "aws_access_key_id"
    note  = "AWS Access Key ID"
  }
  
  AWS_SECRET_ACCESS_KEY = {
    value      = "aws_secret_access_key"
    note       = "AWS Secret Access Key"
    visibility = "restricted"
  }
  
  # Configuración de aplicación
  JWT_SECRET = {
    value      = "jwt_super_secret_key"
    note       = "Secreto para firmar tokens JWT"
    visibility = "restricted"
  }
  
  ENCRYPTION_KEY = {
    value      = "32_char_encryption_key_here"
    note       = "Clave de encriptación AES-256"
    visibility = "restricted"
  }
  
  API_RATE_LIMIT = {
    value = "1000"
    note  = "Límite de requests por minuto"
  }
  
  DEBUG_MODE = {
    value = "false"
    note  = "Modo debug (true/false)"
  }
}
```

### Diferentes Configuraciones por Ambiente

#### Development
```hcl
my_app_dev = {
  DATABASE_URL = {
    value = "postgresql://dev_user:dev_pass@localhost:5432/myapp_dev"
    note  = "Base de datos de desarrollo local"
  }
  DEBUG_MODE = {
    value = "true"
    note  = "Habilitar debug en desarrollo"
  }
  LOG_LEVEL = {
    value = "debug"
    note  = "Nivel de logging detallado"
  }
}
```

#### Staging
```hcl
my_app_staging = {
  DATABASE_URL = {
    value      = "postgresql://staging_user:staging_pass@staging-db:5432/myapp_staging"
    note       = "Base de datos de staging"
    visibility = "restricted"
  }
  DEBUG_MODE = {
    value = "false"
    note  = "Debug deshabilitado en staging"
  }
  LOG_LEVEL = {
    value = "info"
    note  = "Logging nivel info"
  }
  PERFORMANCE_MONITORING = {
    value = "true"
    note  = "Habilitar monitoreo de performance"
  }
}
```

#### Production
```hcl
my_app_prod = {
  DATABASE_URL = {
    value      = "postgresql://prod_user:super_secure_pass@prod-cluster:5432/myapp_prod"
    note       = "Base de datos de producción - CRÍTICO"
    visibility = "restricted"
  }
  DEBUG_MODE = {
    value = "false"
    note  = "Debug completamente deshabilitado"
  }
  LOG_LEVEL = {
    value = "warn"
    note  = "Solo logs de warnings y errores"
  }
  MONITORING_API_KEY = {
    value      = "datadog_api_key_prod"
    note       = "API key para monitoreo en producción"
    visibility = "restricted"
  }
  ERROR_REPORTING_DSN = {
    value      = "sentry_dsn_prod"
    note       = "DSN de Sentry para reportes de errores"
    visibility = "restricted"
  }
  BACKUP_ENCRYPTION_KEY = {
    value      = "backup_encryption_key_32_chars"
    note       = "Clave para encriptar backups"
    visibility = "restricted"
  }
}
```

## 🔧 Configuración por Ambientes

### Development Environment
```hcl
project_secrets = {
  api_dev = {
    DATABASE_URL = {
      value = "postgresql://dev_user:dev_pass@localhost:5432/api_dev"
      note  = "Base de datos de desarrollo con datos de prueba"
    }
    DEBUG_MODE = {
      value = "true"
      note  = "Habilitar logging detallado en desarrollo"
    }
    EXTERNAL_API_URL = {
      value = "https://sandbox.external-api.com"
      note  = "URL del API externo en modo sandbox"
    }
  }
}
```

### Production Environment
```hcl
project_secrets = {
  api_prod = {
    DATABASE_URL = {
      value      = "postgresql://prod_user:CHANGE_ME@prod-db.company.com:5432/api_prod"
      note       = "Base de datos de producción - CRÍTICO"
      visibility = "restricted"
    }
    DEBUG_MODE = {
      value = "false"
      note  = "Deshabilitar debug en producción por seguridad"
    }
    EXTERNAL_API_URL = {
      value = "https://api.external-service.com"
      note  = "URL del API externo en producción"
    }
  }
}
```

## 🏗️ Patrones de Configuración por Tipo de Aplicación

### Aplicación Web Full-Stack
```hcl
webapp_fullstack = {
  # Frontend
  REACT_APP_API_URL = {
    value = "http://localhost:3001/api"
    note  = "URL del backend API para el frontend React"
  }
  
  # Backend
  PORT = {
    value = "3001"
    note  = "Puerto donde corre el servidor backend"
  }
  JWT_SECRET = {
    value      = "super_secret_jwt_key_change_in_prod"
    note       = "Clave secreta para firmar tokens JWT"
    visibility = "restricted"
  }
  
  # Database
  DATABASE_URL = {
    value = "postgresql://webapp_user:webapp_pass@localhost:5432/webapp_db"
    note  = "Conexión completa a PostgreSQL"
  }
  
  # Cache
  REDIS_URL = {
    value = "redis://localhost:6379/1"
    note  = "Redis para sesiones y caché de aplicación"
  }
  
  # Email
  SMTP_HOST = {
    value = "smtp.gmail.com"
    note  = "Servidor SMTP para envío de emails"
  }
  SMTP_USER = {
    value = "noreply@miapp.com"
    note  = "Usuario SMTP para autenticación"
  }
  SMTP_PASS = {
    value      = "smtp_password_here"
    note       = "Contraseña SMTP - mantener segura"
    visibility = "restricted"
  }
}
```

### Microservicio de Pagos
```hcl
payment_service = {
  # Stripe
  STRIPE_PUBLIC_KEY = {
    value = "pk_test_stripe_public_key"
    note  = "Clave pública de Stripe para el frontend"
  }
  STRIPE_SECRET_KEY = {
    value      = "sk_test_stripe_secret_key"
    note       = "Clave secreta de Stripe - CRÍTICA"
    visibility = "restricted"
  }
  STRIPE_WEBHOOK_SECRET = {
    value      = "whsec_stripe_webhook_secret"
    note       = "Secreto para validar webhooks de Stripe"
    visibility = "restricted"
  }
  
  # PayPal
  PAYPAL_CLIENT_ID = {
    value = "paypal_client_id_sandbox"
    note  = "Client ID de PayPal para sandbox"
  }
  PAYPAL_CLIENT_SECRET = {
    value      = "paypal_client_secret_sandbox"
    note       = "Client Secret de PayPal - mantener seguro"
    visibility = "restricted"
  }
  
  # Base de datos de transacciones
  TRANSACTIONS_DB_URL = {
    value = "postgresql://payment_user:payment_pass@localhost:5432/payments"
    note  = "Base de datos dedicada para transacciones"
  }
  
  # Configuración de la aplicación
  MAX_TRANSACTION_AMOUNT = {
    value = "10000.00"
    note  = "Monto máximo permitido por transacción en USD"
  }
  CURRENCY_DEFAULT = {
    value = "USD"
    note  = "Moneda por defecto para todas las transacciones"
  }
}
```

### API de Analytics
```hcl
analytics_api = {
  # Google Analytics
  GA_TRACKING_ID = {
    value = "GA_TRACKING_ID_HERE"
    note  = "ID de seguimiento de Google Analytics"
  }
  GA_API_KEY = {
    value      = "google_analytics_api_key"
    note       = "API key para Google Analytics Reporting API"
    visibility = "masked"
  }
  
  # MongoDB para eventos
  MONGO_URI = {
    value = "mongodb://analytics_user:analytics_pass@localhost:27017/analytics"
    note  = "URI de MongoDB para almacenar eventos de analytics"
  }
  
  # ClickHouse para consultas rápidas
  CLICKHOUSE_URL = {
    value = "http://localhost:8123"
    note  = "URL de ClickHouse para análisis de big data"
  }
  CLICKHOUSE_USER = {
    value = "analytics_user"
    note  = "Usuario para conectar a ClickHouse"
  }
  CLICKHOUSE_PASS = {
    value      = "clickhouse_password"
    note       = "Contraseña de ClickHouse"
    visibility = "restricted"
  }
  
  # Configuración de retención
  DATA_RETENTION_DAYS = {
    value = "365"
    note  = "Días que se mantienen los datos en caliente"
  }
  BATCH_SIZE = {
    value = "1000"
    note  = "Tamaño del lote para procesamiento de eventos"
  }
}
```

## 📊 Configuración Multi-Tenant

```hcl
# Aplicación multi-tenant con configuración por cliente
saas_platform = {
  # Configuración global
  MASTER_DB_URL = {
    value = "postgresql://master_user:master_pass@localhost:5432/saas_master"
    note  = "Base de datos principal con información de tenants"
  }
  
  # Cliente 1
  TENANT_1_DB_URL = {
    value = "postgresql://tenant1_user:tenant1_pass@localhost:5432/tenant_1"
    note  = "Base de datos dedicada para el cliente 1"
  }
  TENANT_1_S3_BUCKET = {
    value = "saas-tenant-1-storage"
    note  = "Bucket S3 exclusivo para archivos del cliente 1"
  }
  
  # Cliente 2
  TENANT_2_DB_URL = {
    value = "postgresql://tenant2_user:tenant2_pass@localhost:5432/tenant_2"
    note  = "Base de datos dedicada para el cliente 2"
  }
  TENANT_2_S3_BUCKET = {
    value = "saas-tenant-2-storage"
    note  = "Bucket S3 exclusivo para archivos del cliente 2"
  }
  
  # Configuración de facturación
  BILLING_API_KEY = {
    value      = "billing_service_api_key"
    note       = "API key para el servicio de facturación automática"
    visibility = "restricted"
  }
}
```

## 🛡️ Mejores Prácticas de Seguridad

### Rotación de Secrets
```hcl
# Ejemplo con timestamp para tracking de rotación
api_secure = {
  API_KEY_CURRENT = {
    value = "api_key_2024_09_09"
    note  = "API key actual - rotada el 2024-09-09"
  }
  API_KEY_PREVIOUS = {
    value = "api_key_2024_08_09"
    note  = "API key anterior - mantener por 30 días para rollback"
  }
  
  JWT_SECRET_V2 = {
    value      = "jwt_secret_version_2_2024_09"
    note       = "JWT secret versión 2 - rotado mensualmente"
    visibility = "restricted"
  }
}
```

### Configuración por Roles
```hcl
# Secrets específicos por rol de usuario
role_based_app = {
  # Admin
  ADMIN_MASTER_KEY = {
    value      = "admin_master_key_super_secret"
    note       = "Clave maestra para operaciones administrativas"
    visibility = "restricted"
  }
  
  # API Users
  API_RATE_LIMIT = {
    value = "1000"
    note  = "Límite de requests por hora para usuarios API"
  }
  
  # Service to Service
  SERVICE_TOKEN = {
    value      = "service_to_service_auth_token"
    note       = "Token para comunicación entre microservicios"
    visibility = "masked"
  }
}
```

## 📝 Comandos Útiles

```bash
# Ver toda la documentación de secrets
terraform output secrets_documentation

# Ver resumen de configuración
terraform output doppler_configuration_summary

# Aplicar solo cambios en outputs (sin tocar infraestructura)
terraform apply -refresh-only

# Validar configuración antes de aplicar
terraform validate && terraform plan
```
