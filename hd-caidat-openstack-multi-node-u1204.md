# HDCD - OpenStack Icehouse - Multi node

# Thông tin LAB

- 3 máy chủ: Controller, Network, Compute1
- Mỗi máy 03 card mạng: eth0, eth1, eth2

# Mô hình đấu nối

# Các bước thực hiện

## Thao tác trên tất cả các máy chủ
Truy cập bằng tài khoản root vào máy Controller, tải các gói chuẩn bị cho quá trình cài đặt

	apt-get install git -y
	git clone https://github.com/congto/icehouse-multinode-ubuntu.git
	mv /root/icehouse-multinode-ubuntu/script-ubuntu1204/ script-ubuntu1204
	cd script-ubuntu1204
	chmod +x *.sh

## Sửa file khai báo các thông số trước khi thực thi shell
Các máy chủ đang để IP động
Dùng vi để sửa file config.cfg với các IP theo ý bạn hoặc giữ nguyên các IP và đảm bảo chúng chưa được gán cho máy nào trong mạng của bạn.
Sau khi thay đổi xong chuyển qua thực thi các file dưới.

	
## Thực thi script thiết lập IP, hostname ...

	bash control-1.ipadd.sh
