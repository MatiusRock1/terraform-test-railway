# Configuración de providers
terraform {
  required_providers {
    railway = {
      source  = "terraform-community-providers/railway"
      version = "~> 0.5.0"
    }
    doppler = {
      source  = "DopplerHQ/doppler"
      version = "~> 1.6.0"
    }
  }
}

# Configurar el provider de Railway
provider "railway" {
  token = var.railway_token
}

# Configurar el provider de Doppler
provider "doppler" {
  doppler_token = var.doppler_token
}

# Import existing Railway project
import {
  to = railway_project.demo
  id = "3adc1782-c73d-4e62-8fa4-25c35451b0df"
}

# Railway Project - will be imported, not created
resource "railway_project" "demo" {
  name = "Demo Jorge TP"
}

# Crear nuevo environment "dev2-terraform"
resource "railway_environment" "dev2" {
  name       = "dev2-terraform"
  project_id = railway_project.demo.id
}

# Crear el servicio MongoDB Single Replica en dev 2
resource "railway_service" "mongodb" {
  name         = "mongodb-replica-dev2"
  project_id   = railway_project.demo.id
  source_image = "bitnami/mongodb:7.0"
}

# Variables para MongoDB Single Replica en dev 2 (Bitnami)
# MongoDB variables are managed in dev2-variables.tf for the existing environment

# Crear el servicio Hello World en dev 2
resource "railway_service" "app" {
  name         = "hello-world-dev2"
  project_id   = railway_project.demo.id
  source_image = "testcontainers/helloworld:latest"
}

# TCP Proxy para MongoDB is managed in dev2-variables.tf

# Crear el proyecto en Doppler
resource "doppler_project" "demo" {
  name = "demo"
}

# Crear environment en Doppler para dev 2
resource "doppler_environment" "dev2" {
  project = doppler_project.demo.name
  slug    = "dev2"
  name    = "dev2"
}

# Crear configuración en Doppler para dev 2
resource "doppler_config" "dev2" {
  project     = doppler_project.demo.name
  environment = doppler_environment.dev2.slug
  name        = "dev2_backend"
}

# Secrets en Doppler para dev 2
resource "doppler_secret" "mongodb_internal_url" {
  project = doppler_project.demo.name
  config  = doppler_config.dev2.name
  name    = "MONGODB_INTERNAL_URL"
  value   = "mongodb://admin:password123@mongodb-single-replica.railway.internal:27017/demo"
}

resource "doppler_secret" "mongodb_public_url" {
  project = doppler_project.demo.name
  config  = doppler_config.dev2.name
  name    = "MONGODB_PUBLIC_URL"
  value   = "mongodb://admin:password123@${railway_tcp_proxy.dev2_mongodb_public.domain}:${railway_tcp_proxy.dev2_mongodb_public.proxy_port}/demo"
}

resource "doppler_secret" "database_url" {
  project = doppler_project.demo.name
  config  = doppler_config.dev2.name
  name    = "DATABASE_URL"
  value   = "mongodb://admin:password123@${railway_tcp_proxy.dev2_mongodb_public.domain}:${railway_tcp_proxy.dev2_mongodb_public.proxy_port}/demo"
}
