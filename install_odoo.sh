#!/bin/sh

# usage: ./install_plone.sh

$AS_VAGRANT=sudo -u vagrant

sudo apt-get install -y git-core
sudo apt-get install -y python-pip
sudo apt-get install -y python-dev
sudo apt-get install -y libxml2-dev libxslt-dev
sudo apt-get install -y postgresql
sudo apt-get install -y python-psycopg2
sudo apt-get install -y libpq-dev
sudo apt-get install -y libldap2-dev libsasl2-dev libssl-dev
sudo apt-get install python-virtualenv
sudo -u postgres createuser vagrant --superuser

cd /usr/local/bin
sudo wget http://sourceforge.net/projects/wkhtmltopdf/files/0.12.1/wkhtmltox-0.12.1_linux-precise-amd64.deb
sudo dpkg -i wkhtmltox-0.12.1_linux-precise-amd64.deb
cd /usr/bin
sudo ln -s ../local/bin/wkhtmltopdf wkhtmltopdf

echo "DONE!"
echo "Ready to install Odoo !"

export HOME=/home/vagrant/

cd /home/vagrant/odoo
$AS_VAGRANT mkdir instance-70
$AS_VAGRANT mkdir instance-70/log
$AS_VAGRANT mkdir instance-80
$AS_VAGRANT mkdir instance-80/log
CWD=`pwd`
cd ./instance-70
$AS_VAGRANT ln -s ../buildout-70.cfg buildout.cfg
cd $CWD
cd ./instance-80
$AS_VAGRANT ln -s ../buildout-80.cfg buildout.cfg
cd $CWD

$AS_VAGRANT virtualenv instance-70
$AS_VAGRANT ./instance-70/bin/pip install zc.buildout
$AS_VAGRANT virtualenv instance-80
$AS_VAGRANT ./instance-80/bin/pip install zc.buildout

CWD=`pwd`
cd instance-70
$AS_VAGRANT ./bin/buildout -vvv
cd $CWD
if [ ! -f ./instance-70/bin/start_openerp ] 
then
	echo "Instance 7.0 creation error. Please restart them"
	exit 1
fi
cd instance-80
$AS_VAGRANT ./bin/buildout -vvv
cd $CWD
if [ ! -f ./instance-80/bin/start_openerp ] 
then
	echo "Instance 8.0 creation error. Please restart them"
	exit 1
fi

if [ -f /etc/init/odoo-server-70.conf ] 
then 
   sudo rm /etc/init/odoo-server-70.conf
fi

if [ -L /etc/init.d/odoo-server-70 ] 
then 
   sudo rm /etc/init.d/odoo-server-70
fi

sudo touch /etc/init/odoo-server-70.conf
echo "setuid vagrant" | sudo tee /etc/init/odoo-server-70.conf
echo "setgid vagrant" | sudo tee -a /etc/init/odoo-server-70.conf
echo "start on filesystem or runlevel[45]" | sudo tee -a /etc/init/odoo-server-70.conf
echo "stop on runlevel[!45]" | sudo tee -a /etc/init/odoo-server-70.conf
echo "exec /home/vagrant/odoo/instance-70/bin/start_openerp --proxy-mode" | sudo tee -a /etc/init/odoo-server-70.conf
sudo ln -s /lib/init/upstart-job /etc/init.d/odoo-server-70
sudo service odoo-server-70 restart

if [ -f /etc/init/odoo-server-80.conf ] 
then 
   sudo rm /etc/init/odoo-server-80.conf
fi

if [ -L /etc/init.d/odoo-server-80 ] 
then 
   sudo rm /etc/init.d/odoo-server-80
fi

sudo touch /etc/init/odoo-server-80.conf
echo "setuid vagrant" | sudo tee /etc/init/odoo-server-80.conf
echo "setgid vagrant" | sudo tee -a /etc/init/odoo-server-80.conf
echo "start on filesystem or runlevel[45]" | sudo tee -a /etc/init/odoo-server-80.conf
echo "stop on runlevel[!45]" | sudo tee -a /etc/init/odoo-server-80.conf
echo "exec /home/vagrant/odoo/instance-80/bin/start_openerp --proxy-mode" | sudo tee -a /etc/init/odoo-server-80.conf
sudo ln -s /lib/init/upstart-job /etc/init.d/odoo-server-80
sudo service odoo-server-80 restart

echo
echo "DONE!"
echo "You may now run Odoo instance 7.0 or 8.0."
