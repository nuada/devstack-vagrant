#!/bin/bash
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o bond0 -j MASQUERADE
iptables -A FORWARD -i bond0 -o vboxnet1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i vboxnet1 -o bond0 -j ACCEPT
