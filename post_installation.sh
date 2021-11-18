#!/bin/bash

# Update, upgrade and clean up verything
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove --purge -y && sudo apt-get update
# Uninstall what you don't need
# Uninstall thunderbird
sudo apt-get update
sudo apt-get remove thunderbird --purge -y
sudo apt-get autoremove --purge -y
sudo apt-get update
# Install Brave browser
sudo apt-get update
sudo apt install apt-transport-https curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y
sudo apt-get update
# Install Snapd
sudo apt-get update
sudo apt-get install snapd -y
sudo apt-get update
# Install C&C Red Alert
# sudo snap install cncra -y
# Install C&C Red Alert Yuri's Revenge
# sudo snap install cncra2yr -y
# Install VLC player
sudo apt-get update
sudo apt-get install vlc -y
sudo apt-get update
# Install git
sudo apt-get update
sudo apt-get install git -y
sudo apt-get update
# Install Visual Studio Code
sudo apt-get update
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code
sudo apt-get update
# Configure Github
git config --global user.name "Iulian Donici"
git config --global user.email "iuliandonici@gmail.com"
git config --global color.ui auto

# mkdir ~/dev/repos
# cd ~/dev/repos
sudo apt install apt-transport-https
sudo apt update
sudo apt install code