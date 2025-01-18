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

# Check if Docker Compose is installed
if docker compose version &> /dev/null; then
    echo "Docker Compose is already installed"
else
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

echo "Docker installation complete!" 