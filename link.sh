#!/bin/sh

cd /home/vagrant
sudo rm -rf *.sh
cd /home/vagrant/odoo
sudo -u vagrant find -maxdepth 1 -name "*.sh" -exec ln -s odoo/{} ../{} \; 
cd ..
chmod u+x *.sh