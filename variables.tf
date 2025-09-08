# Variables de Railway
variable "railway_token" {
  description = "Token de autenticación para Railway"
  type        = string
  sensitive   = true
}

# Variables de Doppler
variable "doppler_token" {
  description = "Token de autenticación para Doppler"
  type        = string
  sensitive   = true
}

# Variables del proyecto
variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "demo"
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"
}
