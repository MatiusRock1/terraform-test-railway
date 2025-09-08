const mongoose = require('mongoose');

// URL de conexión pública de tu MongoDB replica set
const MONGO_URL = 'mongodb://admin:password123@shinkansen.proxy.rlwy.net:17461/demo?replicaSet=rs0';

console.log('🔗 Conectando a MongoDB replica set...');
console.log('URL:', MONGO_URL.replace('password123', '***'));

// Esquema de prueba
const TestSchema = new mongoose.Schema({
  name: String,
  timestamp: { type: Date, default: Date.now },
  message: String
});

const TestModel = mongoose.model('Test', TestSchema);

async function testConnection() {
  try {
    // Conectar a MongoDB
    await mongoose.connect(MONGO_URL, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    
    console.log('✅ Conexión exitosa a MongoDB replica set!');
    
    // Verificar el estado del replica set
    const admin = mongoose.connection.db.admin();
    const status = await admin.command({ replSetGetStatus: 1 });
    console.log('📊 Estado del Replica Set:', status.set);
    console.log('📊 Miembros:', status.members.length);
    
    // Insertar un documento de prueba
    const testDoc = new TestModel({
      name: 'Prueba desde Mongoose',
      message: 'MongoDB replica set funcionando correctamente!'
    });
    
    const saved = await testDoc.save();
    console.log('💾 Documento guardado:', saved._id);
    
    // Leer documentos
    const docs = await TestModel.find().limit(5);
    console.log('📖 Documentos encontrados:', docs.length);
    
    docs.forEach((doc, index) => {
      console.log(`  ${index + 1}. ${doc.name} - ${doc.timestamp}`);
    });
    
    console.log('🎉 ¡Todas las pruebas pasaron exitosamente!');
    
  } catch (error) {
    console.error('❌ Error:', error.message);
    
    if (error.message.includes('authentication failed')) {
      console.log('🔐 Problema de autenticación - verifica usuario/password');
    } else if (error.message.includes('ECONNREFUSED')) {
      console.log('🔌 No se puede conectar - verifica que MongoDB esté corriendo');
    } else if (error.message.includes('replica set')) {
      console.log('🔄 Problema con replica set - verifica configuración');
    }
  } finally {
    await mongoose.disconnect();
    console.log('👋 Desconectado de MongoDB');
  }
}

// Ejecutar la prueba
testConnection();
