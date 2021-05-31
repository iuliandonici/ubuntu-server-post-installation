#!/bin/bash

sudo apt-get update
# Install Git
sudo apt-get install git -y
# Install nmap so we can scan for other network devices
sudo apt-get install nmap -y
# Install mosh so you can have a better speed shen ssh-ing over wi-fi:
sudo apt-get install mosh -y
# Install smartmontools for disk health checks
sudo apt-get install smartmontools -y