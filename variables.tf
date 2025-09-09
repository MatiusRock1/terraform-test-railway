# Variables de Doppler
variable "doppler_token" {
  description = "Token de autenticación para Doppler"
  type        = string
  sensitive   = true
}

# Variables de configuración
variable "environment_name" {
  description = "Nombre del environment"
  type        = string
  default     = "dev"
}

variable "config_name" {
  description = "Nombre de la configuración (debe empezar con el environment)"
  type        = string
  default     = "dev_backend"
}

variable "project_secrets" {
  description = "Configuración completa de secrets por proyecto con notas y valores por defecto"
  type = map(map(object({
    value       = string
    note        = string
    visibility  = optional(string, "masked")
  })))
  default = {
    # Proyecto de ejemplo - Backend API
    example_backend = {
      DATABASE_URL = {
        value = "postgresql://user:pass@localhost:5432/backend_db"
        note  = "URL de conexión a la base de datos principal"
      }
      API_KEY = {
        value = "your_api_key_here"
        note  = "Clave API para servicios externos"
      }
      JWT_SECRET = {
        value = "change_me_in_production"
        note  = "Secreto para firmar tokens JWT"
      }
    }
    
    # Proyecto de ejemplo - Frontend
    example_frontend = {
      REACT_APP_API_URL = {
        value = "http://localhost:3001/api"
        note  = "URL del backend API para el frontend"
      }
      REACT_APP_ENV = {
        value = "development"
        note  = "Entorno de la aplicación React"
      }
    }
  }
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}
