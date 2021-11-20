#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get update
sudo apt-get install mokutil -y
mkdir /root/module-signing
cp -r adjust3_with_kernel_updates_vb.sh /root/module-signing/
chmod 700 /root/module-signing/adjust3_with_kernel_updates_vb.sh
cd /root/module-signing
openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=Iulian Donici/"
chmod 600 MOK.priv
mokutil --import /root/module-signing/MOK.der
