// Script para inicializar el replica set de MongoDB
rs.initiate({
  _id: "rs0",
  members: [
    {
      _id: 0,
      host: "mongodb-replica-dev2.railway.internal:27017"
    }
  ]
});

// Crear usuario admin
db = db.getSiblingDB('admin');
db.createUser({
  user: "admin",
  pwd: "password123",
  roles: [
    { role: "userAdminAnyDatabase", db: "admin" },
    { role: "readWriteAnyDatabase", db: "admin" },
    { role: "dbAdminAnyDatabase", db: "admin" },
    { role: "clusterAdmin", db: "admin" }
  ]
});

// Crear base de datos demo
use demo;
db.test.insertOne({message: "MongoDB Replica Set initialized successfully!"});
