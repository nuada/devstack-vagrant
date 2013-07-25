#!/bin/bash

source /opt/stack/devstack/openrc admin
nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
nova keypair-add --pub-key /vagrant/devstack_rsa.pub key1
