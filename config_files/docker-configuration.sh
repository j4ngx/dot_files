#!/bin/bash

# Update the system and install required packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index and install Docker
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify that Docker is installed correctly
sudo docker --version
sudo docker compose version

# Enable Docker to start on boot
sudo systemctl enable docker
sudo systemctl start docker

# Create app-data directory if it doesn't exist
mkdir -p ~/app-data/docker-volumes
mkdir -p ~/app-data/portainer

# Install Portainer using Docker, storing data in ~/app-data/portainer
sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/app-data/portainer:/data portainer/portainer-ce:latest

# Output installation success message
echo "Docker, Docker Compose, and Portainer have been installed successfully."
echo "All application data is stored in ~/app-data."
