#!/bin/bash -ex
#

# Cau hinh cho file /etc/hosts
ADMIN_PASS=a
iphost=/etc/hosts
test -f $iphost.orig || cp $iphost $iphost.orig
rm $iphost
touch $iphost
cat << EOF >> $iphost
127.0.0.1       localhost
10.10.10.71    controller
127.0.0.1       controller
10.10.10.73      compute1
10.10.10.74      compute2
10.10.10.72     network
EOF

# Cai dat repos va update
#apt-get install python-software-properties -y
#add-apt-repository cloud-archive:icehouse
# apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y

apt-get update -y
apt-get upgrade -y
apt-get dist-upgrade -y

# Cai dat NTP va cau hinh NTP 
apt-get install ntp -y
cp /etc/ntp.conf /etc/ntp.conf.bka
rm /etc/ntp.conf
cat /etc/ntp.conf.bka | grep -v ^# | grep -v ^$ >> /etc/ntp.conf
#
sed -i 's/server/#server/' /etc/ntp.conf
echo "server controller" >> /etc/ntp.conf

# Cai dat RABBITMQ  va cau hinh RABBITMQ
apt-get install rabbitmq-server -y
rabbitmqctl change_password guest $ADMIN_PASS
