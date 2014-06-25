#!/bin/bash -ex
#

echo "###########TAO FILE CHO BIEN MOI TRUONG##################"
echo "export OS_USERNAME=admin" > admin-openrc.sh
echo "export OS_PASSWORD=a" >> admin-openrc.sh 
echo "export OS_TENANT_NAME=admin" >> admin-openrc.sh
echo "export OS_AUTH_URL=http://controller:35357/v2.0" >> admin-openrc.sh