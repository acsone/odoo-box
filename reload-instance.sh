#!/bin/sh

AS_VAGRANT=sudo -u vagrant

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
	exit 1
fi

if [ $1 -ne 70 ] && [ $1 -ne 80 ]; then
    echo "Usage : reload-instance 70 or reload-instance 80 "
	exit 1
fi

if [ ! -d /home/vagrant/odoo/instance-$1 ] 
then 
   echo "Instance is not created ... \nAbort ..."
   exit 1
fi

export HOME=/home/vagrant/

echo "Attempt to stop instance ..."
sudo service odoo-server-$1 stop || echo "Instance is not running ..."

cd /home/vagrant/odoo
CWD=`pwd`
cd instance-$1
$AS_VAGRANT ./bin/buildout
cd $CWD
if [ ! -f ./instance-$1/bin/start_openerp ] 
then
	echo "Instance $1 reload error. Please restart them"
	exit 1
fi

echo "Instance $1 of Odoo is reloaded!"
