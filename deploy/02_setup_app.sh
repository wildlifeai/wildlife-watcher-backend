#!/bin/bash

# Set your Key Vault details
VAULT_NAME="secrets-staging"

# Create .env file
echo "Downloading all secrets from Azure Key Vault..."

# Initialize the .env file
> .env

# Get all secrets from Key Vault and format them for .env
az keyvault secret list --vault-name $VAULT_NAME --query "[].name" -o tsv | while read secret_name; do
    # Get the value for each secret
    value=$(az keyvault secret show --vault-name $VAULT_NAME --name "$secret_name" --query "value" -o tsv)
    
    # Convert hyphenated name back to uppercase with underscores
    env_name=$(echo "$secret_name" | tr '-' '_' | tr '[:lower:]' '[:upper:]')
    
    # Add to .env file
    echo "$env_name=$value" >> .env
    echo "Added secret: $env_name"
done

echo "Environment variables downloaded successfully!"

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
