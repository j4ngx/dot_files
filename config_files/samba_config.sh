#!/bin/bash

# Update and install Samba
echo "Updating package lists and installing Samba..."
sudo apt-get update
sudo apt-get install -y samba

# Backup the original Samba configuration file
echo "Backing up the original Samba configuration..."
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# Add the configuration for sharing /media/nas/Shared
echo "Configuring Samba to share /media/nas/Shared..."
sudo tee -a /etc/samba/smb.conf > /dev/null <<EOL

[Shared]
   path = /media/nas/Shared
   browseable = yes
   read only = no
   guest ok = yes
   create mask = 0755
EOL

# Set the permissions for the shared directory
echo "Setting permissions for the shared directory..."
sudo chown -R nobody:nogroup /media/nas/Shared
sudo chmod -R 0755 /media/nas/Shared

# Restart Samba services to apply the changes
echo "Restarting Samba services..."
sudo systemctl restart smbd
sudo systemctl restart nmbd

# Enable Samba services to start on boot
echo "Enabling Samba services to start on boot..."
sudo systemctl enable smbd
sudo systemctl enable nmbd

echo "Samba setup complete. The directory /media/nas/Shared is now shared on the network."
