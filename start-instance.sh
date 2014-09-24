#!/bin/sh

AS_VAGRANT="sudo -u vagrant"

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
	exit 1
fi

if [ $1 -ne 70 ] && [ $1 -ne 80 ]; then
    echo "Usage : start-instance 70 or start-instance 80 "
	exit 1
fi

if [ ! -d /home/vagrant/odoo/instance-$1 ] 
then 
   echo "Instance is not created ... \nAbort ..."
   exit 1
fi

echo "Attempting to stop other Odoo instance ..."
pkill -f start_openerp
echo "Attempting to start $1 Odoo instance ..."
sudo service odoo-server-$1 start || exit 1

echo "Instance $1 of Odoo is started"
