#!/bin/bash

# UUIDs for the partitions
UUID_1TB="08f9d22d-c723-4af5-9784-e0be0d9b714f"
UUID_2TB="4f63d937-5668-4c0d-8053-ff86c8dbbe4e"

# Backup the existing /etc/fstab
sudo cp /etc/fstab /etc/fstab.bak

# Append new mount points to /etc/fstab
echo "UUID=$UUID_1TB /media/nas ext4 defaults 0 2" | sudo tee -a /etc/fstab
echo "UUID=$UUID_2TB /media/films ext4 defaults 0 2" | sudo tee -a /etc/fstab

# Create the mount points if they don't already exist
sudo mkdir -p /media/nas
sudo mkdir -p /media/films

# Remount all filesystems based on the updated /etc/fstab
sudo mount -a

# Verify mounts
df -h | grep '/media/nas\|/media/films'
