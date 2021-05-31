#!/bin/bash

# Configure Git after installing it
# git config --global user.email "iuliandonici@gmail.com"
# git config --global user.name "Iulian Donici"

# Configure locales for mosh
sudo update-locale LC_ALL="en_US.UTF-8"
# Speed up the SSH connection uncommenting "#UseDNS no", making it "UseDNS no" by using sed.
# First we backup the current /etc/ssh/sshd_config
sudo cp -r /etc/ssh/sshd_config /etc/ssh/sshd_config.bak_original
# Now use sed
# sudo sed -i 's/#UseDNS/UseDNS/g' /etc/ssh/sshd_config
# Apply the changes made by restarting the sshd service
# sudo systemctl status ssh.service
# sudo systemctl restart ssh.service
# sudo systemctl status ssh.service
# or it could've been restarted by:
# sudo systemctl restart ssh
# sudo service ssh restart

# Copy the generated ssh key to busyserver
# ssh-copy-id busyneo@192.168.1.19
