#!/bin/bash

# Backup the original configuration.
sudo cp -r /etc/systemd/logind.conf /etc/systemd/logind.conf.bak_original
# We need to change #HandleLidSwitch=suspend do HandleLidSwitch=ignore
sudo sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/g' /etc/systemd/logind.conf
# And then change #LidSwitchIgnoreInhibited=yes to LidSwitchIgnoreInhibited=no
sudo sed -i 's/#LidSwitchIgnoreInhibited=yes/LidSwitchIgnoreInhibited=no/g' /etc/systemd/logind.conf
# Apply the changes by restarting the systemd-logind.service
sudo systemctl restart systemd-logind.service