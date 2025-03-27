#!/bin/bash

# Create node user and group with specific IDs if they don't exist
groupadd -g 1000 node 2>/dev/null || true
useradd -u 1000 -g node node 2>/dev/null || true

# Set permissions for Strapi directories
sudo chown -R 1000:1000 ./src
sudo chown -R 1000:1000 ./config
sudo chown -R 1000:1000 ./public
sudo chmod -R 755 ./src
sudo chmod -R 755 ./config
sudo chmod -R 755 ./public

echo "Permissions have been updated. You can now start your Strapi container."
