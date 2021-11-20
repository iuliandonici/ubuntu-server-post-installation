#!/bin/bash

# VARIABLES
lid_config_file="/etc/systemd/logind.conf";
# Check if the file containing the lid part even exists
if [ -f $lid_config_file ];
 then {
        echo $lid_config_file "is there!";
        # # Backup the original configuration.
        sudo cp -r $lid_config_file $lid_config_file.backup_original
        # We need to change #HandleLidSwitch=suspend do HandleLidSwitch=ignore
        sudo sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/g' /etc/systemd/logind.conf
        # And then change #LidSwitchIgnoreInhibited=yes to LidSwitchIgnoreInhibited=no
        sudo sed -i 's/#LidSwitchIgnoreInhibited=yes/LidSwitchIgnoreInhibited=no/g' /etc/systemd/logind.conf
        # Apply the changes by restarting the systemd-logind.service
        # sudo systemctl restart systemd-logind.service
        # Restarting the system-logind
        # sudo systemctl restart systemd-logind
        # Restarting the entire system
        sudo reboot
 }
 else
echo $lid_config_file "is not there, so we have to find a different solution!";
fi
