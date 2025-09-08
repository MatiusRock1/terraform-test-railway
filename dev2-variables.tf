# Variables adicionales para el environment "dev 2" existente
# Environment ID de "dev 2": 8f68dc5b-4279-4323-aebc-9e387ba656e8
# Service ID de mongodb-replica-dev2: 9dbcc694-d3d4-4f8a-bce4-e0648967cb1f

# Variables para MongoDB Single Replica en dev 2 (Bitnami)
resource "railway_variable" "dev2_mongodb_root_user" {
  name           = "MONGODB_ROOT_USER"
  value          = "admin"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

resource "railway_variable" "dev2_mongodb_root_password" {
  name           = "MONGODB_ROOT_PASSWORD" 
  value          = "password123"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

resource "railway_variable" "dev2_mongodb_database" {
  name           = "MONGODB_DATABASE"
  value          = "demo"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

# Configuración para replica set en dev 2 (Bitnami)
resource "railway_variable" "dev2_mongodb_replica_set_mode" {
  name           = "MONGODB_REPLICA_SET_MODE"
  value          = "primary"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

resource "railway_variable" "dev2_mongodb_replica_set_name" {
  name           = "MONGODB_REPLICA_SET_NAME"
  value          = "rs0"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

# Clave secreta para autenticación del replica set
resource "railway_variable" "dev2_mongodb_replica_set_key" {
  name           = "MONGODB_REPLICA_SET_KEY"
  value          = "myReplicaSetKey123456789"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

resource "railway_variable" "dev2_mongodb_advertised_hostname" {
  name           = "MONGODB_ADVERTISED_HOSTNAME"
  value          = "localhost"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

# Puerto para MongoDB en dev 2
resource "railway_variable" "dev2_mongodb_port" {
  name           = "PORT"
  value          = "27017"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

# Variables adicionales que Railway espera para MongoDB - mantienen referencia interna
resource "railway_variable" "dev2_mongohost" {
  name           = "MONGOHOST" 
  value          = "localhost"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

resource "railway_variable" "dev2_mongoport" {
  name           = "MONGOPORT"
  value          = "27017"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

resource "railway_variable" "dev2_mongouser" {
  name           = "MONGOUSER"
  value          = "admin"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

resource "railway_variable" "dev2_mongopassword" {
  name           = "MONGOPASSWORD"
  value          = "password123"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

resource "railway_variable" "dev2_mongo_url" {
  name           = "MONGO_URL"
  value          = "mongodb://admin:password123@localhost:27017/demo?replicaSet=rs0"
  service_id     = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
}

# TCP Proxy para MongoDB en dev 2
resource "railway_tcp_proxy" "dev2_mongodb_public" {
  service_id       = "9dbcc694-d3d4-4f8a-bce4-e0648967cb1f"
  environment_id   = "8f68dc5b-4279-4323-aebc-9e387ba656e8"
  application_port = 27017
}
