#!/bin/bash

# This is the script that will include all scripts.

# First, we update the list
sudo apt-get update
# Then we upgrade
sudo apt-get upgrade -y
# And now, we're going to clean up left-overs:
sudo apt-get autoremove --purge -y

# BACKUP SYSTEM FILES
# We need to make a backup of the files we're going to chage.
# First, we're backup the only and defauly netplan yaml configuration:
sudo cp -r /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.original_yaml

# INSTALL WIRELESS-TOOLS
# Install from offline the 'wireless-tools' .deb package's dependent libraries:
sudo dpkg -i kits/libc6_2.31-0ubuntu9_amd64.deb
sudo dpkg -i kits/libiw30_30_pre9-13ubuntu1_amd64.deb
# Install the 'wireless-tools' .deb package itself:
sudo dpkg -i kits/wireless-tools_30_pre9-13ubuntu1_amd64.deb
# We first want to know the name of the wireless interface
cd /sys/class/net
# Now, we can list the interfaces but filter it by using "wlp" so we can grep the full name of the wireless interface:
ls | grep wlp > $HOME/wireless_interface_name
cd ~
wireless_interface=$(cat wireless_interface_name);
echo "The wireless interface name is:";
echo $wireless_interface;
# We're making sure that the wireless interface is up by bringing it first down and then up:
sudo ip link set $wireless_interface down
sudo ip link set $wireless_interface up
echo "Wireless interface : UP";
# Now, we're trying to get the name of the ethernet interface:
cd ~
ethernet_interface=$(cat ethernet_interface_name);
echo "The ethernet interface name is:";
echo $ethernet_interface;
# Remove the current .yaml config:
sudo rm -rf /etc/netplan/*.yaml
# Start creating a new one, where you make the ethernet interface an OPTIONAL one so that the Network Manager won't use it by default at boot.
sudo echo "network:
    version: 2
    renderer: networkd
    ethernets:
        $ethernet_interface:
            dhcp4: true
            optional: true" > 01_make_eth_optional_at_boot.yaml
# Copy the file to the right place:
sudo cp -r *.yaml /etc/netplan/
# Apply the new network config
sudo netplan apply
echo "$ethernet_interface_name is now set optional at boot."
# Install WPA_SUPPLICANT
# Install offline 'wpasupplicant's .deb package dependent libraries:
cd $HOME/kits/
sudo dpkg -i libdbus-1-3_1.12.16-2ubuntu2.1_amd64.deb
sudo dpkg -i libnl-3-200_3.4.0-1_amd64.deb
sudo dpkg -i libnl-genl-3-200_3.4.0-1_amd64.deb
sudo dpkg -i libnl-route-3-200_3.4.0-1_amd64.deb
sudo dpkg -i libpcsclite1_1.8.26-3_amd64.deb
sudo dpkg -i libreadline8_8.0-4_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.2_amd64.deb
sudo dpkg -i lsb-base_11.1.0ubuntu2_all.deb
sudo dpkg -i adduser_3.118ubuntu2_all.deb
# Install offline the 'wpasupplicant' .deb package itself:
sudo dpkg -i wpasupplicant_2.9-1ubuntu4.3_amd64.deb
# CREATE WPA_SUPPLICANT.CONF
# Input the name of your wireless network:
read -p "Wireless network name: " wireless_ssid;
# Insert your wireless ssid's password.
# the -p asks for user for the input;
# the -s makes the input silent, can't see it, like for a password:
read -s -p "Wireless password: " wireless_ssid_password;
# echo $wireless_ssid_password;
wpa_passphrase $wireless_ssid $wireless_ssid_password | sudo tee /etc/wpa_supplicant.conf
# Connect to your wireless network but leave the process in the background:
sudo wpa_supplicant -B -c /etc/wpa_supplicant.conf -i $wireless_interface
# Copy the 'wpa_supplicant' service file so that when OS upgrade is done, the configuration is not missing:
sudo cp -r /lib/systemd/system/wpa_supplicant.service /etc/systemd/system/wpa_supplicant.service
# Configure the new /etc/systemd/system/wpa_supplicant.service file:
sudo sed -i "s/-u -s -O \/run\/wpa_supplicant/-u -s -c \/etc\/wpa_supplicant.conf -i $wireless_interface \nRestart=always/g" /etc/systemd/system/wpa_supplicant.service
sudo sed -i "s/Alias=dbus-fi/#Alias=dbus-fi/g" /etc/systemd/system/wpa_supplicant.service
# Reload systemd
sudo systemctl daemon-reload
# Enable wpa_supplicant to start at boot:
sudo systemctl enable wpa_supplicant.service



# DHCHP on boot
#Create the template file"
echo "[Unit]
Description=DHCP Client
Before=network.target
After=wpa_supplicant.service

[Service]
Type=forking
ExecStart=/sbin/dhclient $wireless_interface -v
ExecStop=/sbin/dhclient $wireless_interface -r
Restart=always

[Install]
WantedBy=multi-user.target" > dhclient.service

# Copy the dhclient service
sudo cp -r dhclient.service /etc/systemd/system/dhclient.service

# Enable the DHCP Client at boot
sudo systemctl enable dhclient.service

# Let me know:
echo "After reboot, DHCP will be enabled."





# CLEANUP, again
sudo apt-get autoremove --purge -y
# Enter your home directory
cd ~
# Delete .yaml configurations
sudo rm -rf *.yaml
# Delete the dhclient file
sudo rm -rf dhclient.service
# Delete network files/left-overs
sudo rm -rf *interface_name
sudo rm -rf $HOME/wireless_interface
# Delete $HOME/ethernet_interface_name
sudo rm -rf $HOME/ethernet_interface_name
# Apply everything by rebooting
sudo reboot now