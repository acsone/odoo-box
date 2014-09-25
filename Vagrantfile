# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.box = "odoo-box"
    config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
	config.vm.forward_port 8069, 8069
	config.vm.forward_port 8169, 8169
	
	config.ssh.max_tries = 150
	
	config.vm.provision :shell do |shell|
	  shell.inline = "sudo /etc/init.d/networking restart"
	end
	
	config.vm.provision :shell do |shell|
	  shell.inline = "sudo apt-get install -y git-core"
	end
	
	config.vm.provision :shell do |shell|
	  shell.inline = "cd $1"
	  shell.args = %q{/home/vagrant/}
	end
	
	config.vm.provision :shell do |shell|
	  shell.inline = "sudo -u $1 touch clone.sh"
	  shell.args = %q{vagrant}
	end
	
	config.vm.provision :shell do |shell|
	  shell.inline = "echo $1 > clone.sh"
	  shell.args = %q{"#!/bin/sh"}
	end
	
	config.vm.provision :shell do |shell|
	  shell.inline = "echo $1 >> clone.sh"
	  shell.args = %q{"if [ ! -d ./odoo ]; then sudo -u vagrant git clone https://github.com/adrienpeiffer/odoo-box.git odoo;else cd ./odoo;sudo -u vagrant git reset --hard origin/master;sudo -u vagrant git pull; cd ..;fi"}
	end
	
	config.vm.provision :shell do |shell|
	  shell.inline = "sudo chmod u+x $1"
	  shell.args = %q{./clone.sh}
	end
	
	config.vm.provision :shell do |shell|
	  shell.inline = "./clone.sh"
	end
	
	config.vm.provision :shell do |shell|
	  shell.inline = "sudo chmod u+x $1"
	  shell.args = %q{./odoo/link.sh}
	end
	
	config.vm.provision :shell do |shell|
	  shell.inline = "./odoo/link.sh"
	end
	
	config.vm.provision :shell do |shell|
	  shell.inline = "sudo -u $1 ./install_odoo_dependencies.sh"
	  shell.args = %q{vagrant}
	end
	
end
