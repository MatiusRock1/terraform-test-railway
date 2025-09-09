# Outputs de los proyectos Doppler creados
output "doppler_projects_created" {
  description = "Lista de proyectos Doppler creados"
  value = {
    for key, project in doppler_project.projects : key => project.name
  }
}

output "doppler_environments_created" {
  description = "Lista de environments creados para cada proyecto"
  value = {
    for key, env in doppler_environment.environments : key => env.name
  }
}

output "doppler_configs_created" {
  description = "Lista de configuraciones creadas para cada proyecto"
  value = {
    for key, config in doppler_config.configs : key => config.name
  }
}

output "doppler_secrets_created" {
  description = "Lista de secrets creados organizados por proyecto con sus notas"
  value = {
    for project, secrets in var.project_secrets : project => {
      for secret_name, secret_config in secrets : secret_name => {
        note       = secret_config.note
        visibility = secret_config.visibility
        # No mostramos el valor por seguridad
      }
    }
  }
}

# Output adicional para mostrar un resumen de configuración
output "doppler_configuration_summary" {
  description = "Resumen de la configuración aplicada"
  value = {
    total_projects = length(keys(var.project_secrets))
    total_secrets  = sum([for project, secrets in var.project_secrets : length(secrets)])
    projects_with_secrets = {
      for project in keys(var.project_secrets) : project => length(var.project_secrets[project])
    }
  }
}

# Output para documentación de secrets (sin valores sensibles)
output "secrets_documentation" {
  description = "Documentación de todos los secrets configurados"
  value = {
    for project, secrets in var.project_secrets : project => [
      for secret_name, secret_config in secrets : {
        name        = secret_name
        description = secret_config.note
        visibility  = secret_config.visibility
      }
    ]
  }
}
