#!/bin/bash

nets=('10.0.0.254' '172.16.0.254')

for i in ${!nets[*]}; do
	VBoxManage hostonlyif remove vboxnet${i}
	VBoxManage hostonlyif create
	VBoxManage hostonlyif ipconfig vboxnet${i} --ip ${nets[$i]} --netmask 255.255.255.0
	VBoxManage dhcpserver remove --ifname vboxnet${i}
done
