# Configuración de providers
terraform {
  required_providers {
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "~> 1.6.0"
    }
  }
}

# Configurar el provider de Doppler
provider "doppler" {
  doppler_token = var.doppler_token
}

# ========================================
# PROYECTOS DOPPLER (dinámicos desde project_secrets)
# ========================================

# Crear proyectos dinámicamente basados en las keys de project_secrets
resource "doppler_project" "projects" {
  for_each = var.project_secrets
  name     = each.key
}

# Crear environments dinámicamente
resource "doppler_environment" "environments" {
  for_each = var.project_secrets
  project  = doppler_project.projects[each.key].name
  slug     = var.environment_name
  name     = var.environment_name
}

# Crear configuraciones dinámicamente
resource "doppler_config" "configs" {
  for_each    = var.project_secrets
  project     = doppler_project.projects[each.key].name
  environment = doppler_environment.environments[each.key].slug
  name        = var.config_name
}

# ========================================
# SECRETS DOPPLER (usando for_each anidado con notas y valores)
# ========================================

# Crear una lista de combinaciones proyecto-variable para los secrets
locals {
  project_secret_combinations = [
    for project_name, secrets in var.project_secrets : [
      for secret_name, secret_config in secrets : {
        project       = project_name
        secret_name   = secret_name
        secret_config = secret_config
        key           = "${project_name}_${secret_name}"
      }
    ]
  ]
  # Aplanar la lista anidada
  project_secrets = flatten(local.project_secret_combinations)
}

# Crear secrets dinámicamente con valores por defecto y notas
resource "doppler_secret" "secrets" {
  for_each = {
    for item in local.project_secrets : item.key => item
  }
  
  project    = doppler_project.projects[each.value.project].name
  config     = doppler_config.configs[each.value.project].name
  name       = each.value.secret_name
  value      = each.value.secret_config.value
  visibility = each.value.secret_config.visibility
  
  # Nota: Los valores se establecen inicialmente por Terraform,
  # pero pueden ser modificados manualmente en Doppler después
}
