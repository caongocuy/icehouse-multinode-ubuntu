# HDCD - OpenStack Icehouse - Multi node

# A. Thông tin LAB

## 1. Mô hình đấu nối

## 2. Thiết lập cho từng node
- 3 máy chủ: Controller, Network, Compute1
- Mỗi máy 03 card mạng: eth0, eth1, eth2



# B. Các bước thực hiện chung

## 1. Thao tác trên tất cả các máy chủ
Truy cập bằng tài khoản root vào máy các máy chủ và tải các gói, script chuẩn bị cho quá trình cài đặt

	apt-get install git -y
	git clone https://github.com/congto/icehouse-multinode-ubuntu.git
	mv /root/icehouse-multinode-ubuntu/script-ubuntu1204/ script-ubuntu1204
	cd script-ubuntu1204
	chmod +x *.sh

## 2. Sửa file khai báo các thông số trước khi thực thi shell
Trước lúc chỉnh sửa, KHÔNG cần gán IP tĩnh cho các NICs trên từng máy chủ.
Dùng vi để sửa file config.cfg nằm trong thư mục script-ubuntu1204 với các IP theo ý bạn hoặc giữ nguyên các IP và đảm bảo chúng chưa được gán cho máy nào trong mạng của bạn.
File gốc như sau: (tốt nhất đặt giống file gốc)

	# Khai bao IP cho CONTROLLER NODE
	CON_MGNT_IP=10.10.10.71
	CON_EXT_IP=192.168.1.71

	# Khai bao IP cho NETWORK NODE
	NET_MGNT_IP=10.10.10.72
	NET_EXT_IP=192.168.1.72
	NET_DATA_VM_IP=10.10.20.72

	# Khai bao IP cho COMPUTE1 NODE
	COM1_MGNT_IP=10.10.10.73
	COM1_EXT_IP=192.168.1.73
	COM1_DATA_VM_IP=10.10.20.73

	# Khai bao IP cho COMPUTE2 NODE
	COM2_MGNT_IP=10.10.10.74
	COM2_EXT_IP=192.168.1.74
	COM2_DATA_VM_IP=10.10.20.74

	GATEWAY_IP=192.168.1.1
	NETMASK_ADD=255.255.255.0

	# Set password
	DEFAULT_PASS='Welcome123'


Sau khi thay đổi xong chuyển qua thực thi các file dưới trên từng node

# C. Thực hiện trên CONTROLLER NODE
## C.1. Thực thi script thiết lập IP, hostname ...

	bash control-1.ipadd.sh
	
Sau khi thực hiện script trên, máy Controller sẽ khởi động lại và được gán IP tĩnh.

## C.2. Cài đặt các gói MYSQL, NTP cho Controller Node
Đăng nhập vào Controller bằng địa chỉ CON_EXT_IP (file gốc là 192.168.1.71) khai báo trong file config.cfg với tài khoản root.
Ssau đó di chuyển vào thư mục script-ubuntu1204 bằng lệnh cd 

    cd script-ubuntu1204

Thực thi file control-2.prepare.sh

    bash control-2.prepare.sh

## C.3. Tạo Database cho các thành phần 
Thực thi shell dưới để tạo các database, user của database cho các thành phần

    bash control-3.create-db.sh
    
## C.4 Cài đặt và cấu hình keystone

    bash control-4.keystone.sh

Sau khi cài xong keystone, thực thi biến môi trường

    source admin-openrc.sh

Và kiểm tra lại dịch vụ keystone xem đã hoạt động tốt chưa bằng lệnh dưới

     keystone user-list

Kết quả của lệnh keystone user-list như sau 

    +----------------------------------+---------+---------+-----------------------+
    |                id                |   name  | enabled |         email         |
    +----------------------------------+---------+---------+-----------------------+
    | eda2f227988a45fcbc9ffb0abd405c6c |  admin  |   True  |  congtt@teststack.com |
    | 07f996af33f14415adaf8d6aa6b8be83 |  cinder |   True  |  cinder@teststack.com |
    | 6a198132f715468e860fa25d8163888e |   demo  |   True  |  congtt@teststack.com |
    | 4fa14e44dafb48f09b2febaa2a665311 |  glance |   True  |  glance@teststack.com |
    | 5f345c4a266d4c7691831924e1eec1f5 | neutron |   True  | neutron@teststack.com |
    | d4b7c90da1c148be8741168c916cf149 |   nova  |   True  |   nova@teststack.com  |
    | ddcb21870b4847b4b72853cfe7badd07 |  swift  |   True  |  swift@teststack.com  |
    +----------------------------------+---------+---------+-----------------------+

Chuyển qua cài các dịch vụ tiếp theo

## C.5. Tạo user, role, tenant, phân quyền cho user và tạo các endpoint
Shell dưới thực hiện việc tạo user, tenant và gán quyền cho các user. Ngoài ra còn tạo ra các endpoint cho các dịch vụ. Các biến trong shell được lấy từ file config.cfg

    bash control-5-creatusetenant.sh
    
## C.6. Cài đặt thành phần GLANCE
GLANCE dùng để cung cấp image template để khởi tạo máy ảo

    bash control-6.glance.sh
    
## C.7 Cài đặt NOVA

    bash control-7.nova.sh
    
## C.8 Cài đặt NEUTRON

    bash control-8.neutron.sh
    

Tạm dừng việc cài đặt trên CONTROLLER NODE, sau khi cài xong NETWORK NODE và COMPUTE1 NODE sẽ quay lại để cài HORIZON và tạo các network, router.

# D. CÀI ĐẶT TRÊN NETWORKNODE
Cài đặt NEUTRON, ML2 và cấu hình GRE, sử dụng use case per-router per-tenant.
Lưu ý: Thực hiện bước tải script từ github về như hướng dẫn ở bước trên cùng

## D.1. Thực hiện đặt IP cho NETWORK NODE với tham số khai báo trong file
Script thực hiện việc cài đặt OpenvSwitch và khai báo br-int & br-ex cho OpenvSwitch

    bash net-ipadd.sh

NETWORK NODE sẽ khởi động lại, cần phải đăng nhập lại sau khi khởi động xong bằng tài khoản root.

## D.2. Thực thi việc cài đặt NEUTRON và cấu hình

    bash net-prepare.sh

Kết thúc cài đặt trên NETWORK NODE và chuyển sang cài đặt COMPUTE NODE

# E. CÀI ĐẶT TRÊN COMPUTE NODE (COMPUTE1)
Lưu ý: Thực hiện cài đặt gói git và tải các script từ github về theo hướng dẫn ở bước trên cùng
Thực hiện các shell dưới để thiết lập hostname, gán ip và cài đặt các thành phần của nove trên máy COMPUTE NODE

## E.1. Đặt hostname, IP và các gói bổ trợ

    bash com1-ipdd.sh
    
## E.2. Cài đặt các gói của NOVA cho COMPUTE NODE

    bash com1-prepare.sh
    
Kết thúc bước cài đặt trên COMPUTE NODE, chuyển về CONTROLLER NODE.



# F. CÀI HORIZON, tạo các network trên CONTROLLER NODE

## F.1. Cài đặt Horizon

    bash control-horizon.sh

## F.2. Tạo PUBLIC NET, PRIVATE NET, ROUTER
Thực hiện script dưới để tạo các loại network cho OpenStack
Tạo router, gán subnet cho router, gán gateway cho router 
Khởi tạo một máy ảo với image là cirros để test

    bash creat-network.sh
    
# KÊT THÚC












