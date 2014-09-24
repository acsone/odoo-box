#!/bin/sh

AS_VAGRANT="sudo -u vagrant"

if [ $# -eq 0 ]; then
    echo "Usage : build-instance 70 or build-instance 80"
	exit 1
fi

if [ $1 -ne 70 ] && [ $1 -ne 80 ]; then
    echo "Usage : build-instance 70 or build-instance 80"
	exit 1
fi

if [ -f /etc/init/odoo-server-$1.conf ] 
then 
   echo "Instance $1 is already built. Please launch 'ssh -c \"./reload-instance $1\"'"
   exit 1
fi

git config --global user.email "you@example.com"
git config --global user.name "you@example.com"

export HOME=/home/vagrant/

cd /home/vagrant/odoo
$AS_VAGRANT mkdir instance-$1  || exit 1
$AS_VAGRANT mkdir instance-$1/log || exit 1
CWD=`pwd`
cd ./instance-$1
$AS_VAGRANT ln -s ../buildout-base-$1.cfg buildout-base.cfg || exit 1
$AS_VAGRANT ln -s ../buildout-$1.cfg buildout.cfg  || exit 1
cd $CWD

$AS_VAGRANT virtualenv instance-$1 || exit 1
$AS_VAGRANT ./instance-$1/bin/pip install zc.buildout || exit 1

sudo touch /etc/init/odoo-server-$1.conf || exit 1
echo "setuid vagrant" | sudo tee /etc/init/odoo-server-$1.conf
echo "setgid vagrant" | sudo tee -a /etc/init/odoo-server-$1.conf
echo "exec /home/vagrant/odoo/instance-$1/bin/start_openerp --proxy-mode" | sudo tee -a /etc/init/odoo-server-$1.conf
sudo ln -s /lib/init/upstart-job /etc/init.d/odoo-server-$1 || exit 1

CWD=`pwd`
cd instance-$1
$AS_VAGRANT ./bin/buildout
cd $CWD
if [ ! -f ./instance-$1/bin/start_openerp ] 
then
	echo "Instance $1 creation error. Please restart them with 'ssh -c \"./reload-instance $1\"'"
	exit 1
fi

echo "Instance $1 of Odoo is created !"
