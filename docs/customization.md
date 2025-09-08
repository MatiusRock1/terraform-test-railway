# Personalización de la Aplicación

Esta guía explica cómo personalizar la aplicación si necesitas usar tu propia imagen Docker o código.

## 🐳 Imagen Docker actual

Actualmente el proyecto usa la imagen `testcontainers/helloworld`, que es una aplicación de prueba simple que:

- ✅ Responde en el puerto 8080
- ✅ Muestra una página "Hello World" básica
- ✅ Es perfecta para pruebas de concepto

## 🔄 Cambiar a imagen personalizada

### Opción 1: Usar otra imagen de Docker Hub

Edita `main.tf`:

```hcl
resource "railway_service" "app" {
  name       = "hello-world-app"
  project_id = railway_project.demo.id
  
  source = {
    image = "nginx:alpine"  # Ejemplo: usar nginx
  }
  
  variables = {
    PORT = "80"  # Cambiar puerto según la imagen
  }
}
```

### Opción 2: Usar repositorio Git con Dockerfile

Si quieres volver a usar un repositorio Git con Dockerfile personalizado:

1. **Agrega la variable git_repo en `variables.tf`:**

```hcl
variable "git_repo" {
  description = "URL del repositorio Git para el servicio"
  type        = string
  default     = "https://github.com/tu-usuario/tu-repo"
}
```

2. **Modifica el servicio en `main.tf`:**

```hcl
resource "railway_service" "app" {
  name       = "hello-world-app"
  project_id = railway_project.demo.id
  
  source = {
    repo   = var.git_repo
    branch = "main"
  }
  
  variables = {
    PORT = "3000"
  }
}
```

3. **Actualiza `terraform.tfvars.example`:**

```hcl
git_repo = "https://github.com/tu-usuario/tu-repo"
```

## 📝 Aplicación Node.js personalizada

Si quieres crear tu propia aplicación Node.js que use las variables de MongoDB:

### 1. Crear package.json

```json
{
  "name": "railway-mongo-app",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "mongodb": "^6.0.0"
  }
}
```

### 2. Crear index.js

```javascript
const express = require('express');
const { MongoClient } = require('mongodb');

const app = express();
const PORT = process.env.PORT || 3000;

// URLs de MongoDB desde Doppler
const INTERNAL_URL = process.env.MONGODB_INTERNAL_URL;
const PUBLIC_URL = process.env.MONGODB_PUBLIC_URL;
const DATABASE_URL = process.env.DATABASE_URL;

app.get('/', async (req, res) => {
  try {
    // Intentar conectar a MongoDB
    const client = new MongoClient(DATABASE_URL || INTERNAL_URL);
    await client.connect();
    
    const db = client.db('demo');
    const collection = db.collection('test');
    
    // Insertar un documento de prueba
    await collection.insertOne({ 
      message: 'Hello from Railway!', 
      timestamp: new Date() 
    });
    
    // Obtener documentos
    const docs = await collection.find({}).limit(10).toArray();
    
    await client.close();
    
    res.json({
      message: 'Connected to MongoDB successfully!',
      documents_count: docs.length,
      latest_docs: docs
    });
  } catch (error) {
    res.status(500).json({
      error: 'Could not connect to MongoDB',
      details: error.message,
      mongodb_internal: !!INTERNAL_URL,
      mongodb_public: !!PUBLIC_URL,
      database_url: !!DATABASE_URL
    });
  }
});

app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date() });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
  console.log('MongoDB URLs configured:', {
    internal: !!INTERNAL_URL,
    public: !!PUBLIC_URL,
    database: !!DATABASE_URL
  });
});
```

### 3. Crear Dockerfile

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```

## 🔧 Configuración para diferentes tipos de aplicación

### Python con Flask

```python
from flask import Flask, jsonify
import os
from pymongo import MongoClient

app = Flask(__name__)

@app.route('/')
def hello():
    try:
        client = MongoClient(os.getenv('DATABASE_URL'))
        db = client.demo
        collection = db.test
        
        result = collection.insert_one({'message': 'Hello from Python!'})
        
        return jsonify({
            'message': 'Hello from Python + MongoDB!',
            'inserted_id': str(result.inserted_id)
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.getenv('PORT', 5000)))
```

### Go con Gin

```go
package main

import (
    "context"
    "log"
    "net/http"
    "os"
    
    "github.com/gin-gonic/gin"
    "go.mongodb.org/mongo-driver/mongo"
    "go.mongodb.org/mongo-driver/mongo/options"
)

func main() {
    r := gin.Default()
    
    r.GET("/", func(c *gin.Context) {
        mongoURL := os.Getenv("DATABASE_URL")
        if mongoURL == "" {
            c.JSON(500, gin.H{"error": "MongoDB URL not configured"})
            return
        }
        
        client, err := mongo.Connect(context.TODO(), options.Client().ApplyURI(mongoURL))
        if err != nil {
            c.JSON(500, gin.H{"error": err.Error()})
            return
        }
        defer client.Disconnect(context.TODO())
        
        c.JSON(200, gin.H{
            "message": "Hello from Go + MongoDB!",
            "status":  "connected",
        })
    })
    
    port := os.Getenv("PORT")
    if port == "" {
        port = "8080"
    }
    
    r.Run(":" + port)
}
```

## 🚀 Desplegar aplicación personalizada

1. **Crear repositorio** con tu aplicación
2. **Actualizar variables** en Terraform
3. **Aplicar cambios**:

```bash
terraform plan
terraform apply
```

4. **Verificar despliegue** en Railway dashboard

## 📚 Recursos útiles

- [Railway Documentation](https://docs.railway.app/)
- [Docker Hub](https://hub.docker.com/)
- [Dockerfile Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Railway Templates](https://railway.app/templates)
