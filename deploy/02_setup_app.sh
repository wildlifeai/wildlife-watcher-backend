#!/bin/bash
# Create .env file
cat > .env << EOL
DATABASE_USERNAME=strapi
DATABASE_PASSWORD=3kbt5465h0bvclfrjh5430vje39
DATABASE_NAME=strapi
EOL

# Create persistent directory for PostgreSQL
sudo mkdir -p /opt/wildlife-watcher-backend/postgres-data
sudo chown -R 999:999 /opt/wildlife-watcher-backend/postgres-data  # 999 is postgres user in container

# Start the stack
docker compose -f docker-compose.prod.yml up -d

echo "Setup complete! Access Strapi at:"
echo "Admin: http://YOUR_VM_IP:1337/admin"
echo "API: http://YOUR_VM_IP:1337/api" 