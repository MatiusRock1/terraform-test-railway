const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware para parsear JSON
app.use(express.json());

// Ruta principal
app.get('/', (req, res) => {
  res.json({
    message: 'Hello World!',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development',
    mongodb_internal: process.env.MONGODB_INTERNAL_URL ? 'Configured' : 'Not configured',
    mongodb_public: process.env.MONGODB_PUBLIC_URL ? 'Configured' : 'Not configured'
  });
});

// Ruta de health check
app.get('/health', (req, res) => {
  res.json({
    status: 'OK',
    uptime: process.uptime(),
    timestamp: new Date().toISOString()
  });
});

// Ruta para mostrar variables de entorno de la base de datos
app.get('/db-config', (req, res) => {
  res.json({
    mongodb_internal_configured: !!process.env.MONGODB_INTERNAL_URL,
    mongodb_public_configured: !!process.env.MONGODB_PUBLIC_URL,
    database_url_configured: !!process.env.DATABASE_URL
  });
});

// Iniciar el servidor
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Servidor ejecutándose en el puerto ${PORT}`);
  console.log(`📊 Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`🗄️ MongoDB Internal: ${process.env.MONGODB_INTERNAL_URL ? 'Configured' : 'Not configured'}`);
  console.log(`🌐 MongoDB Public: ${process.env.MONGODB_PUBLIC_URL ? 'Configured' : 'Not configured'}`);
});
