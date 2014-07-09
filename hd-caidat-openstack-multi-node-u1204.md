# HDCD - OpenStack Icehouse - Multi node

# Thông tin LAB

- 3 máy chủ: Controller, Network, Compute1
- Mỗi máy 03 card mạng: eth0, eth1, eth2

# Mô hình đấu nối

# Các bước thực hiện

## Thao tác trên tất cả các máy chủ
Truy cập bằng tài khoản root vào máy các máy chủ và tải các gói, script chuẩn bị cho quá trình cài đặt

	apt-get install git -y
	git clone https://github.com/congto/icehouse-multinode-ubuntu.git
	mv /root/icehouse-multinode-ubuntu/script-ubuntu1204/ script-ubuntu1204
	cd script-ubuntu1204
	chmod +x *.sh

## Sửa file khai báo các thông số trước khi thực thi shell
Trước lúc chỉnh sửa, KHÔNG cần gán IP tĩnh cho các NICs trên từng máy chủ.
Dùng vi để sửa file config.cfg với các IP theo ý bạn hoặc giữ nguyên các IP và đảm bảo chúng chưa được gán cho máy nào trong mạng của bạn.
File gốc như sau: (tốt nhất đặt giống file gốc)

	\# Khai bao IP cho CONTROLLER NODE
	CON_MGNT_IP=10.10.10.71
	CON_EXT_IP=192.168.1.71

	\# Khai bao IP cho NETWORK NODE
	NET_MGNT_IP=10.10.10.72
	NET_EXT_IP=192.168.1.72
	NET_DATA_VM_IP=10.10.20.72

	\# Khai bao IP cho COMPUTE1 NODE
	COM1_MGNT_IP=10.10.10.73
	COM1_EXT_IP=192.168.1.73
	COM1_DATA_VM_IP=10.10.20.73

	\# Khai bao IP cho COMPUTE2 NODE
	COM2_MGNT_IP=10.10.10.74
	COM2_EXT_IP=192.168.1.74
	COM2_DATA_VM_IP=10.10.20.74

	GATEWAY_IP=192.168.1.1
	NETMASK_ADD=255.255.255.0

	\# Set password
	DEFAULT_PASS='Welcome123'


Sau khi thay đổi xong chuyển qua thực thi các file dưới.

	
## Thực thi script thiết lập IP, hostname ...

	bash control-1.ipadd.sh
	
Sau khi thực hiện script trên, máy Controller sẽ khởi động lại và được gán IP tĩnh.

## Cài đặt các gói MYSQL, NTP cho Controller Node
Đăng nhập vào Controller bằng địa chỉ CON_EXT_IP (file gốc là 192.168.1.71) khai báo trong file config.cfg với tài khoản root.
Ssau đó di chuyển vào thư mục script-ubuntu1204 bằng lệnh cd 

    cd script-ubuntu1204

Thực thi file control-2.prepare.sh

	bash control-2.prepare.sh















