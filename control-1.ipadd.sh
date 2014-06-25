#!/bin/bash -ex
ifaces=/etc/network/interfaces
test -f $ifaces.orig || cp $ifaces $ifaces.orig
rm $ifaces
touch $ifaces
cat << EOF >> $ifaces
#Dat IP cho Controller node

# LOOPBACK NET 
auto lo
iface lo inet loopback

# DATA NETWORK
auto eth0
iface eth0 inet static
address 10.10.10.71
netmask 255.255.255.0


# EXT NETWORK
auto eth1
iface eth1 inet static
address 192.168.1.71
netmask 255.255.255.0
gateway 192.168.1.1
dns-nameservers 8.8.8.8
EOF

#Khoi dong lai cac card mang vua dat
# service networking restart

#service networking restart
# ifdown eth0 && ifup eth0
# ifdown eth1 && ifup eth1
# ifdown eth2 && ifup eth2


#sleep 5
init 6
#




