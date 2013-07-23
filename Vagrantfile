# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "precise64"
	config.vm.box_url = "http://files.vagrantup.com/precise64.box"

	config.vm.network :forwarded_port, guest: 80, host: 8080
	config.vm.network :private_network, ip: "10.0.0.1"
	config.vm.network :private_network, ip: "172.16.0.1"

	config.vm.provider :virtualbox do |vb|
#		vb.gui = true
		vb.customize ["modifyvm", :id, "--memory", "4096"]
		vb.customize ["modifyvm", :id, "--cpus", "2"]
	end

	config.vm.provision :shell, :path => "bootstrap.sh"
end