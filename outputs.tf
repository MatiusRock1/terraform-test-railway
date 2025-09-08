# Outputs del proyecto Railway para dev 2
output "railway_project_id" {
  description = "ID del proyecto en Railway"
  value       = railway_project.demo.id
}

output "railway_project_url" {
  description = "URL del proyecto en Railway"
  value       = "https://railway.app/project/${railway_project.demo.id}"
}

# Outputs del environment dev 2
output "dev2_environment_id" {
  description = "ID del environment dev 2"
  value       = railway_environment.dev2.id
}

# Outputs del servicio MongoDB en dev 2
output "mongodb_service_id" {
  description = "ID del servicio MongoDB en dev 2"
  value       = railway_service.mongodb.id
}

output "mongodb_internal_url" {
  description = "URL interna de MongoDB en dev 2"
  value       = "mongodb://admin:password123@mongodb-single-replica.railway.internal:27017/demo"
  sensitive   = true
}

output "mongodb_public_url" {
  description = "URL pública de MongoDB en dev 2"
  value       = "mongodb://admin:password123@${railway_tcp_proxy.dev2_mongodb_public.domain}:${railway_tcp_proxy.dev2_mongodb_public.proxy_port}/demo"
  sensitive   = true
}

output "mongodb_public_domain" {
  description = "Dominio y puerto público de MongoDB en dev 2"
  value       = "${railway_tcp_proxy.dev2_mongodb_public.domain}:${railway_tcp_proxy.dev2_mongodb_public.proxy_port}"
}

# Outputs del servicio Hello World en dev 2
output "app_service_id" {
  description = "ID del servicio Hello World en dev 2"
  value       = railway_service.app.id
}

# Outputs de Doppler para dev 2
output "doppler_project_id" {
  description = "ID del proyecto en Doppler"
  value       = doppler_project.demo.id
}

output "doppler_config_id" {
  description = "ID de la configuración dev 2 en Doppler"
  value       = doppler_config.dev2.id
}
