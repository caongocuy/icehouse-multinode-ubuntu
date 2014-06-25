#!/bin/bash -ex

###################
#CAI DAT DASHBOARD
###################

echo "#################Cài đặt Dashboard#################"
apt-get install apache2 memcached libapache2-mod-wsgi openstack-dashboard -y

echo "############Gỡ bỏ openstack-dashboard-ubuntu-theme################"
sleep 7
apt-get remove --purge openstack-dashboard-ubuntu-theme -y

# Fix loi 
echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf
sudo a2enconf servername 
## /* Khởi động lại apache và memcached
service apache2 restart
service memcached restart