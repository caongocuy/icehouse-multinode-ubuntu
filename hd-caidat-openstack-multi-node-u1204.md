# HDCD - OpenStack Icehouse - Multi node

# Thông tin LAB

- 3 máy chủ: Controller, Network, Compute1
- Mỗi máy 03 card mạng: eth0, eth1, eth2

# Mô hình đấu nối

# Các bước thực hiện

## Thao tác trên Controller Node

- Truy cập bằng tài khoản root vào máy Controller, tải các gói chuẩn bị cho quá trình cài đặt
  
    apt-get install git -y
    git clone https://github.com/congto/icehouse-multinode-ubuntu.git
    chmod +x icehouse-multinode-ubuntu


