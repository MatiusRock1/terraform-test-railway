#!/bin/bash

# Script de configuración rápida para el proyecto Terraform + Railway + Doppler
# Uso: ./setup.sh

set -e

echo "🚀 Configuración del proyecto Terraform + Railway + Doppler"
echo "============================================================"

# Verificar prerrequisitos
echo "📋 Verificando prerrequisitos..."

if ! command -v terraform &> /dev/null; then
    echo "❌ Terraform no está instalado. Instalándolo..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install terraform
    else
        echo "Por favor instala Terraform manualmente: https://terraform.io/downloads"
        exit 1
    fi
fi

if ! command -v git &> /dev/null; then
    echo "❌ Git no está instalado"
    exit 1
fi

echo "✅ Prerrequisitos verificados"

# Configurar variables de entorno
echo ""
echo "🔧 Configuración de variables de entorno"
echo "========================================="

if [ ! -f "terraform.tfvars" ]; then
    echo "📝 Creando archivo terraform.tfvars..."
    cp terraform.tfvars.example terraform.tfvars
    
    echo ""
    echo "⚠️  IMPORTANTE: Debes editar terraform.tfvars con tus tokens reales"
    echo "   1. Railway token: https://railway.app/account/tokens"
    echo "   2. Doppler token: https://doppler.com/workplace/tokens"
    echo ""
    read -p "¿Quieres editar terraform.tfvars ahora? (y/n): " edit_vars
    
    if [[ $edit_vars == "y" || $edit_vars == "Y" ]]; then
        ${EDITOR:-nano} terraform.tfvars
    fi
else
    echo "✅ Archivo terraform.tfvars ya existe"
fi

# Inicializar Terraform
echo ""
echo "🔄 Inicializando Terraform..."
echo "============================="
terraform init

# Validar configuración
echo ""
echo "✅ Validando configuración..."
terraform validate

# Mostrar plan
echo ""
echo "📋 Plan de ejecución:"
echo "===================="
terraform plan

echo ""
read -p "¿Deseas aplicar estos cambios? (y/n): " apply_changes

if [[ $apply_changes == "y" || $apply_changes == "Y" ]]; then
    echo ""
    echo "🚀 Aplicando configuración..."
    terraform apply -auto-approve
    
    echo ""
    echo "🎉 ¡Despliegue completado exitosamente!"
    echo "======================================="
    echo ""
    echo "⚠️  IMPORTANTE: Ahora necesitas configurar manualmente los servicios en Railway:"
    echo "   1. MongoDB: Usar template 'MongoDB Single Replica'"
    echo "   2. Hello World: Usar imagen testcontainers/helloworld:latest"
    echo ""
    echo "📋 Ver RAILWAY_SETUP.md para instrucciones detalladas"
    echo ""
    echo "📊 Outputs del proyecto:"
    terraform output
    
    echo ""
    echo "🔗 Enlaces útiles:"
    echo "- Railway Dashboard: https://railway.app/"
    echo "- Doppler Dashboard: https://doppler.com/"
    echo "- Aplicación Hello World: $(terraform output -raw app_service_url 2>/dev/null || echo 'URL no disponible aún')"
    echo "- Imagen Docker usada: testcontainers/helloworld"
    
    echo ""
    echo "📚 Próximos pasos:"
    echo "1. Configurar MongoDB con template 'MongoDB Single Replica' (ver RAILWAY_SETUP.md)"
    echo "2. Configurar Hello World con imagen testcontainers/helloworld"
    echo "3. Conectar variables de entorno de Doppler"
    echo "4. Verificar que los servicios estén activos"
    echo "5. Obtener URLs públicas y actualizar variables en Doppler"
else
    echo "❌ Aplicación cancelada"
fi

echo ""
echo "✅ Script completado"
