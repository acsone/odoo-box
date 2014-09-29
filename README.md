# Acsone Test Box for Odoo

The goal of this project is to help functional consultants 
test Pull Requests to OCA modules.

It provides:
* a mechanism to install an Odoo instance with all
OCA modules available
* a documentation on how to easily merge specific 
pull requests in the installed instance

It works on all major operating systems.

From a technical standpoint, it is a Vagrant set-up that installs
a predefined buildout configuration. The user can easily
adapt the buildout to merge pull requests.

## System Requirements

* Operating system supported by Vagrant and Oracle VM VirtualBox
* 64-bit (x64) processor
* Network connection 
* Unused 8069 and 8169 ports
	 
## Software Requirements

* Vagrant from https://www.vagrantup.com/downloads.html for your Operating system
* Oracle VM VirtualBox from https://www.virtualbox.org/wiki/Downloads for your Operating system
* If your operating system is a Microsoft distribution, you have to install CMDER Full(Portable console emulator) from http://bliker.github.io/cmder/
	 
## First Installation

* Download VagrantFile from this repository (above on this webpage) or all file but first is enough and place them on a new directory
* Open your terminal or CMDER.exe (Accept all warnings)
* Navigate to created directory with cd command (see http://ss64.com/bash/cd.html and http://ss64.com/bash/pwd.html)
* Type command 'vagrant up' and press ENTER

At this stage you have an Acsone Test Box which is ready to install Odoo.

If a fatal error occurs during 'vagrant up' execution 
type the command 'vagrant reload --provision' and press ENTER
If the problem persists, please create an issue here on github.
	
## How do I?

## Preamble

All command beginning with "vagrant" must be type on your terminal or CMDER at directory which contains VagrantFile.

### Install Odoo instance

Currently, it's possible to install 7.0 and/or 8.0 Odoo Instance
for instance, 8.0 instance creation :

* vagrant ssh -c "./build-instance.sh 80"
* Wait about 5 minutes (depending of your network connection) during creation of odoo 8.0 instance

If a fatal error occurs during instance build execution such as 'timeout' or 'Instance ... creation error. Please restart them',
type the command 'vagrant ssh -c "./reload-instance.sh 80"' and press ENTER.
If the problem persists, please create an issue here on github.

At this stage you have an installed Acsone Test Box for Odoo 8.0

* vagrant ssh -c "./start-instance.sh 80"

At this stage you have a running Acsone Test Box for Odoo 8.0

### Access the installed instances

Odoo instance is installed on localhost address on 8069 port.
Then, you can open a web browser like Google Chrome or Mozilla Firefox and type 'localhost:8069' in the address bar.

### Stop and start test box

To start Acsone test box :

* vagrant up

To stop :

* vagrant halt

To restart :

* vagrant reload

### Stop and start instances

To start Odoo instance which is build, you can type :

* vagrant ssh -c "./start-instance.sh INSTANCE_VERSION" where INSTANCE_VERSION is 70 or 80 

To stop Odoo instance which is build, you can type :

* vagrant ssh -c "./stop-instance.sh INSTANCE_VERSION"

### Install a Pull Request to an OCA repository in order to test it

* vagrant ssh -c "./add-pr.sh INSTANCE_VERSION REPOSITORY_NAME PULL_REQUEST_NUMBER" 

for exemple, if you want to test : https://github.com/OCA/account-financial-tools/pull/34 on 80 instance you can type :

* vagrant ssh -c "./add-pr.sh 80 account-financial-tools 34" 

WARNING : Don't forget to stop and start instance after this operation

### Remove all Pull Request I have installed

To remove all pull request is installed on an instance. You have to reload this instance :

* vagrant ssh -c "./reload-instance.sh INSTANCE_VERSION"

WARNING : Don't forget to stop and start instance after this operation

### Reset everything in case things go wrong

#### Soft method :

* vagrant reload --provision OR vagrant up --provision (depending on test box state)

And reload instances :

* vagrant ssh -c "./reload-instance.sh INSTANCE_VERSION"

#### Hard method :

* vagrant destroy
* Restart at installation step 4

### Access to Acsone test box with ssh mode

* vagrant ssh




Copyright (c) 2014 Acsone SA/NV (http://www.acsone.eu)
All Rights Reserved

