# Guía de solución de problemas

## 🚨 Trial expirado de Railway

### Síntoma
```
Error: Client Error
Unable to create project, got error: input:3: projectCreate Your trial has expired. Please select a plan to continue using Railway
```

### Solución
1. **Actualizar a un plan de pago**:
   - Ve a [Railway Dashboard → Settings → Billing](https://railway.app/account/billing)
   - Selecciona el plan "Hobby" ($5/mes) o superior
   - Agrega un método de pago válido
   - Una vez activado, ejecuta `terraform apply` nuevamente

2. **Alternativa temporal - usar proyecto existente**:
   Si tienes proyectos creados antes del trial expiration, puedes modificar `main.tf`:
   ```hcl
   # Comentar la creación de nuevo proyecto
   # resource "railway_project" "demo" { ... }
   
   # Usar proyecto existente en su lugar
   data "railway_project" "demo" {
     name = "nombre-de-tu-proyecto-existente"
   }
   
   # Actualizar las referencias en los servicios
   resource "railway_service" "mongodb" {
     name       = "mongodb"
     project_id = data.railway_project.demo.id
   }
   ```

## 🔐 Errores de autorización en servicios

### Síntoma
```
Error: Client Error
Unable to create service, got error: input:3: serviceCreate Not Authorized
```

### Posibles causas y soluciones

1. **Token sin permisos suficientes**:
   - Ve a [Railway Dashboard → Settings → Tokens](https://railway.app/account/tokens)
   - Verifica que tu token tenga permisos "Full Access"
   - Si no los tiene, genera un nuevo token con permisos completos

2. **Plan insuficiente**:
   - Algunos tipos de servicios requieren planes específicos
   - Verifica en Railway Dashboard si tu plan permite crear servicios

3. **Límites de la cuenta**:
   - Revisa si has alcanzado el límite de proyectos/servicios de tu plan
   - Elimina proyectos no utilizados si es necesario

### Solución alternativa: Creación manual + Import
Si Terraform no puede crear los servicios, puedes crearlos manualmente y después importarlos:

1. **Crear servicios manualmente en Railway Dashboard**
2. **Obtener los IDs de los servicios**
3. **Importar a Terraform**:
   ```bash
   terraform import railway_service.mongodb your-mongodb-service-id
   terraform import railway_service.app your-app-service-id
   ```

## 🌐 Problemas de conectividad

### Variables de entorno no se conectan
1. Verifica que los servicios estén desplegados correctamente
2. Confirma que las URLs públicas estén generadas
3. Actualiza manualmente las variables en Doppler si es necesario

### MongoDB no acepta conexiones
1. Verifica que el template "MongoDB Single Replica" esté desplegado
2. Confirma las credenciales en las variables de entorno
3. Revisa los logs del servicio MongoDB en Railway

## 📝 Debugging tips

### Ver estado actual
```bash
terraform show
```

### Ver plan detallado
```bash
terraform plan -detailed-exitcode
```

### Logs de Railway
- Ve a Railway Dashboard → Tu proyecto → Servicio → Logs
- Revisa errores de deployment o runtime

### Validar tokens
```bash
# Verificar que las variables estén configuradas
terraform console
> var.railway_token
> var.doppler_token
```

## 🔄 Empezar de nuevo

Si necesitas reiniciar completamente:

```bash
# Destruir recursos existentes
terraform destroy -auto-approve

# Limpiar estado
rm -rf .terraform/
rm terraform.tfstate*

# Reinicializar
terraform init
terraform plan
terraform apply
```

## 📞 Recursos adicionales

- [Railway Documentation](https://docs.railway.app/)
- [Doppler Documentation](https://docs.doppler.com/)
- [Terraform Railway Provider](https://registry.terraform.io/providers/railway/railway/latest/docs)
