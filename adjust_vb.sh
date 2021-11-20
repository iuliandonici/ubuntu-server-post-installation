#!/bin/bash
sudo apt-cache pkgnames virtualbox >> vb_packages
while read line; do
 echo "sudo apt-get install $line -y" >> vb_packages_install.sh
done < vb_packages
sed -i -e '1i#!/bin/bash\' vb_packages_install.sh
sudo chmod +x vb_packages_install.sh
#sudo ./install_vb.sh
./vb_packages_install.sh
