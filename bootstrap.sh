#!/bin/bash
set -e

# Warm the PIP and APT cache
if [ $(ls -1 /vagrant/pip_cache/ | wc -l) -gt 0 ]
then
	mkdir -p /var/cache/pip
	cp /vagrant/pip_cache/* /var/cache/pip/
fi
if [ $(ls -1 /vagrant/apt_cache/ | wc -l) -gt 0 ]
then
	mkdir -p /var/cache/apt
	cp -R /vagrant/apt_cache/* /var/cache/apt/
fi

# Make apt faster!
sudo sed -i 's/http:\/\/us.archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/mirrors.txt/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -qqy git

# Fetch devstack
git clone -b stable/grizzly https://github.com/openstack-dev/devstack.git
cp /vagrant/localrc devstack/

# Launch devstack!
cd devstack
./stack.sh

#Copy back all PIP cache data to the shared folder, for subsequent use
[[ ! -d /vagrant/pip_cache ]] && mkdir /vagrant/pip_cache
cp /var/cache/pip/* /vagrant/pip_cache
[[ ! -d /vagrant/apt_cache ]] && mkdir /vagrant/apt_cache
cp -R /var/cache/apt/* /vagrant/apt_cache/ || true

# Gateway
ip route add default via 172.16.0.254
