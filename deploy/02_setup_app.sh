#!/bin/bash
# Create .env file
cat > .env << EOL
DATABASE_USERNAME=strapi
DATABASE_PASSWORD=strapi
DATABASE_NAME=strapi
EOL

# Start the stack
docker compose -f docker-compose.prod.yml up -d

echo "Setup complete! Access Strapi at:"
echo "Admin: http://YOUR_VM_IP:1337/admin"
echo "API: http://YOUR_VM_IP:1337/api" 