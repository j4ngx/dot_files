#!/bin/bash

# Get the IP address of the enp2s0 interface
IP=$(ip -4 addr show enp2s0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# Check if the IP was obtained
if [ -z "$IP" ]; then
    echo "Failed to get the IP address of the enp2s0 interface. Ensure that the interface is active."
    exit 1
fi

echo "The IP address of enp2s0 is: $IP"

# Add the IP to the /etc/hosts file for pluton.local
echo "$IP pluton.local" | sudo tee -a /etc/hosts

# Install dnsmasq
sudo apt-get update
sudo apt-get install -y dnsmasq

# Configure dnsmasq
echo "
# dnsmasq configuration
interface=enp2s0
bind-interfaces
domain-needed
bogus-priv
no-resolv
address=/pluton.local/$IP
" | sudo tee /etc/dnsmasq.conf

# Restart dnsmasq to apply the changes
sudo systemctl restart dnsmasq

# Check that dnsmasq is running
sudo systemctl status dnsmasq

echo "Configuration completed. You can now access the server using ssh user@pluton.local from any machine on the network."
