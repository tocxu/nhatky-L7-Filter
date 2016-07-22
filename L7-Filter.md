#L7 DDoS Attack
Lạm dụng bộ nhớ ứng dụng server và giới hạn hiệu suất - giả mạo như các giao dịch hợp lệ.

Giả mạo hành vi của con người, tương tác giao diện

Chủ yếu tấn công dựa vào 2 method:
* HTTP GET
* HTTP POST

#Cơ chế để tấn công
Chỉ gửi header HTTP thật chậm để duy trì kết nối với mục đích đánh sập website.

Gửi nhiều HTTP POST và HTTP GET , đây là hai request hợp lệ, với cùng mục đích như trên khi cố làm quá tải khả năng xử lý của server.
#Cách khắc phục
* Giới hạn số lượng request trên 1 IP
* block IP hoặc một giải IP khả ngh
* Giới hạn số lượng request mà website có thể nhận/ giây
* Giới hạn thời gian time-out
* Kiểm soát cookie
* kết thúc hoặc chi nhỏ các traffic

=>Sử dụng NGINX như một Reverse Proxy 

Sử dụng thêm cách sản phẩm WAF như: 
* Fail2ban ()
* NAXSI
* HAProxy (use it as a layer 7 load balancer))
* 
Giám sát Nginx/Apache với Observium 
 
* hạn chế băng thông với iptables

[more about L7 filter](http://l7-filter.sourceforge.net/HOWTO-kernel)

#Triển khai

Tham khảo:

[secure with nginx 1] (http://www.slideshare.net/wallarm/how-to-secure-your-web-applications-with-nginx)

[secure with nginx 2](https://www.nginx.com/blog/mitigating-os-attacks-with-nginx-and-nginx-plus/)

[fail2ban](https://blog.bullten.com/mitigating-layer7-http-flood-with-nginxfail2ban/)
