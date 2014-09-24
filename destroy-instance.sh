#!/bin/sh

AS_VAGRANT="sudo -u vagrant"

if [ $# -eq 0 ]; then
    echo "Usage : destroy-instance 70 or destroy-instance 80"
	exit 1
fi

if [ $1 -ne 70 ] && [ $1 -ne 80 ]; then
    echo "Usage : destroy-instance 70 or destroy-instance 80"
	exit 1
fi

if [ ! -d /home/vagrant/odoo/instance-$1 ] 
then 
   echo "Instance is not created"
   exit 1
fi

sudo service odoo-server-$1 stop || echo "instance is not running ..."
sudo rm /etc/init/odoo-server-$1.conf || echo "Impossible to remove launch script ..."
sudo rm /etc/init.d/odoo-server-$1 || echo "Impossible to remove launch script link ..."
cd /home/vagrant/odoo
rm -rf instance-$1 || echo "Impossible to remove instance directory ..."

echo "Instance $1 of Odoo is destroyed"
