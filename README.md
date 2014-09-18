Acsone Odoo Box
=======================

Vagrant Set-up using buildout for Odoo.

Software Requirements
---------------------

     * Download and install Vagrant from https://www.vagrantup.com/downloads.html for your Operating system
	 * Download and install Oracle VM VirtualBox from https://www.virtualbox.org/wiki/Downloads for your Operating system
	 * If your operating system is a Microsoft distribution, you should install CMDER (Portable console emulator) from http://bliker.github.io/cmder/
	 
System Requirements
-------------------
	 * Operating system supported by Vagrant and Oracle VM VirtualBox
	 * 64-bit (x64) processor
	 * Network connection 
	 * Unused 8069 and 8169 ports
	 
Acsone Odoo box Installation steps
------------------

	* Download VagrantFile from this repository or all file but first is enough and place them on a new directory
	* Open your terminal or CMDER.exe (Accept all warnings)
	* Navigate to created directory with cd command (see http://ss64.com/bash/cd.html and http://ss64.com/bash/pwd.html)
	* Type command 'vagrant up' and press ENTER
	* Wait about 15 minutes (depending of your network connection) during creation of odoo 7.0 and 8.0 instances

Resolve installation errors
--------------

    * if it happens any problem during 'vagrant up' execution like 'timeout' or 'Instance ... creation error. Please restart them',
	  Please type command 'vagrant reload --provision' and press ENTER
	* if the problem persists, please create an issue
	
Acsone Odoo box shutdown
------------------------

    * Open your terminal or CMDER.exe (Accept all warnings)
	* Navigate to odoo box directory with cd command (see http://ss64.com/bash/cd.html and http://ss64.com/bash/pwd.html)
	* Type command 'vagrant halt' and press ENTER
	
Acsone Odoo box start or restart
------------------------

    * Open your terminal or CMDER.exe (Accept all warnings)
	* Navigate to odoo box directory with cd command (see http://ss64.com/bash/cd.html and http://ss64.com/bash/pwd.html)
	* Type command 'vagrant up' and press ENTER

Acsone Odoo box ssh access
------------------------

    * Open your terminal or CMDER.exe (Accept all warnings)
	* Navigate to odoo box directory with cd command (see http://ss64.com/bash/cd.html and http://ss64.com/bash/pwd.html)
	* Type command 'vagrant ssh' and press ENTER
	* Press CTRL-D to going out of ssh mode
	
Acsone Odoo box destroy (Use with caution)
------------------------

    * Open your terminal or CMDER.exe (Accept all warnings)
	* Navigate to odoo box directory with cd command (see http://ss64.com/bash/cd.html and http://ss64.com/bash/pwd.html)
	* Type command 'vagrant destroy' and press ENTER
	
Modify instance buildout
------------------------

If you want to modify buildout to add addons repository or merge, you can modify it using ssh and nano editor.

Example for instance-80 :

	* Open your terminal or CMDER.exe (Accept all warnings)
	* Navigate to odoo box directory with cd command (see http://ss64.com/bash/cd.html and http://ss64.com/bash/pwd.html)
	* Type command 'vagrant ssh' and press ENTER
	* Type 'cd ./odoo/instance-80/'
	* Type 'nano buildout.cfg'. This command should open a text editor.
	* Modify buildout with this syntax : 'git <Repository address> <local directory> <repository branch> and save file .
	* Now, you have to run the buildout manually by tapping './bin/buildout'
	* And restart service with command 'sudo service odoo-server-80 restart'

Acsone Odoo box buildout reload
------------------------

You can reload buildout to update repositories

    * Open your terminal or CMDER.exe (Accept all warnings)
	* Navigate to odoo box directory with cd command (see http://ss64.com/bash/cd.html and http://ss64.com/bash/pwd.html)
	* Type command 'vagrant reload --provision' and press ENTER

WARNING : This operation will overwrite buildout changes



Copyright (c) 2014 Acsone SA/NV (http://www.acsone.eu)
-------------------------------------------------------
All Rights Reserved
-----------------------------------------------------
	
