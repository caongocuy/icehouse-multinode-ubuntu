#!/bin/bash -ex
#
# Tao file chua bien moi truong

touch keyrc
echo "export OS_USERNAME=admin" >> keyrc
echo "export OS_PASSWORD=a" >> keyrc
echo "export OS_TENANT_NAME=admin" >> keyrc
echo "export OS_AUTH_URL=http://controller:35357/v2.0" >> keyrc
