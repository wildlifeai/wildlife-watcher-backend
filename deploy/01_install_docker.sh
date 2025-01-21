#!/bin/bash

# Check if Docker is installed
if command -v docker &> /dev/null; then
    echo "Docker is already installed"
else
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
fi

# Check if user is in docker group
if groups $USER | grep -q '\bdocker\b'; then
    echo "User already in docker group"
else
    echo "Adding user to docker group..."
    sudo usermod -aG docker $USER
    echo "===================================="
    echo "Running newgrp docker..."
    echo "After this completes, please paste this script again."
    echo "===================================="
    exec newgrp docker
fi

# Install Docker Compose plugin
if ! docker compose version &> /dev/null; then
    echo "Installing Docker Compose plugin..."
    sudo apt-get update
    sudo apt-get install -y docker-compose-plugin
fi

echo "Docker installation complete!" 