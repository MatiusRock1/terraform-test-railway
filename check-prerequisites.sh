#!/bin/bash

# Script para verificar prerequisites del proyecto Railway + Doppler + Terraform

echo "🔍 Verificando prerequisites para Railway + Doppler + Terraform..."
echo "================================================================="

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para imprimir status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
        if [ ! -z "$3" ]; then
            echo -e "${YELLOW}   💡 $3${NC}"
        fi
    fi
}

# Verificar Terraform
echo ""
echo "🔧 Verificando Terraform..."
terraform version > /dev/null 2>&1
print_status $? "Terraform instalado" "Instalar desde: https://terraform.io/downloads"

# Verificar archivo de variables
echo ""
echo "📝 Verificando configuración..."
if [ -f "terraform.tfvars" ]; then
    print_status 0 "Archivo terraform.tfvars existe"
    
    # Verificar variables Railway
    if grep -q "railway_token" terraform.tfvars; then
        print_status 0 "Railway token configurado"
    else
        print_status 1 "Railway token faltante" "Agregar railway_token en terraform.tfvars"
    fi
    
    # Verificar variables Doppler
    if grep -q "doppler_token" terraform.tfvars; then
        print_status 0 "Doppler token configurado"
    else
        print_status 1 "Doppler token faltante" "Agregar doppler_token en terraform.tfvars"
    fi
else
    print_status 1 "Archivo terraform.tfvars faltante" "Crear usando terraform.tfvars.example como base"
fi

# Verificar inicialización de Terraform
echo ""
echo "🏗️  Verificando inicialización de Terraform..."
if [ -d ".terraform" ]; then
    print_status 0 "Terraform inicializado"
else
    print_status 1 "Terraform no inicializado" "Ejecutar: terraform init"
fi

# Test de conectividad (si hay tokens configurados)
echo ""
echo "🌐 Verificando conectividad..."

if [ -f "terraform.tfvars" ] && grep -q "railway_token" terraform.tfvars && grep -q "doppler_token" terraform.tfvars; then
    echo "Ejecutando terraform plan para verificar conectividad..."
    if terraform plan > /dev/null 2>&1; then
        print_status 0 "Conectividad con APIs exitosa"
    else
        print_status 1 "Error de conectividad o autenticación" "Verificar tokens y permisos"
        echo ""
        echo "Ejecutando terraform plan para ver errores detallados:"
        terraform plan
    fi
else
    print_status 1 "No se pueden verificar APIs sin tokens configurados"
fi

echo ""
echo "📋 Resumen de próximos pasos:"
echo "================================================================="

if [ ! -f "terraform.tfvars" ]; then
    echo "1. Copiar terraform.tfvars.example a terraform.tfvars"
    echo "2. Configurar tokens de Railway y Doppler"
fi

if [ ! -d ".terraform" ]; then
    echo "3. Ejecutar: terraform init"
fi

echo "4. Verificar que tu plan de Railway esté activo (no trial expired)"
echo "5. Ejecutar: terraform plan"
echo "6. Si todo está bien: terraform apply"

echo ""
echo "📚 Para más ayuda:"
echo "- README.md: Guía de configuración completa"
echo "- TROUBLESHOOTING.md: Solución de problemas comunes"
echo "- RAILWAY_SETUP.md: Configuración post-despliegue"

echo ""
echo "🎯 Enlaces útiles:"
echo "- Railway Tokens: https://railway.app/account/tokens"
echo "- Doppler Tokens: https://dashboard.doppler.com/"
echo "- Railway Billing: https://railway.app/account/billing"
