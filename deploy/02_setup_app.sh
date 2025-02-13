#!/bin/bash
# Create .env file
cat > .env << EOL
DATABASE_USERNAME=strapi
DATABASE_PASSWORD=3kbt5465h0bvclfrjh5430vje39
DATABASE_NAME=strapi
EOL

# Create the directory if it doesn't exist
sudo mkdir -p /opt/wildlife-watcher-backend/postgres-data

# Set ownership to the postgres user (UID 999 in the container)
sudo chown -R 999:999 /opt/wildlife-watcher-backend/postgres-data

# Set full permissions (read/write/execute) for everyone
sudo chmod 777 /opt/wildlife-watcher-backend/postgres-data

# Start the stack
docker compose -f docker-compose.prod.yml up -d

echo "Setup complete! Access Strapi at:"
echo "Admin: http://YOUR_VM_IP:1337/admin"
echo "API: http://YOUR_VM_IP:1337/api" 