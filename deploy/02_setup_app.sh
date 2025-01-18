#!/bin/bash
# Clone the repository
git clone https://github.com/wildlifeai/wildlife-watcher-backend.git
cd wildlife-watcher-backend

# Create .env file
cat > .env << EOL
DATABASE_USERNAME=strapi
DATABASE_PASSWORD=strapi
DATABASE_NAME=strapi
EOL

# Login to GitHub Container Registry
echo "Please enter your GitHub Personal Access Token (with read:packages scope):"
read -s CR_PAT
echo $CR_PAT | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin

# Start the stack
docker compose -f docker-compose.prod.yml up -d

echo "Setup complete! Access Strapi at:"
echo "Admin: http://YOUR_VM_IP:1337/admin"
echo "API: http://YOUR_VM_IP:1337/api" 