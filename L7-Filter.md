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
## Cấu hình
* Giới hạn mức độ request (Limitting the Rate of requests. Ví dụ, bạn có thể làm cho một IP client cố gắng để đăng nhập mỗi 2 giây ( tương đương 30 yêu cầu-request) mỗi phút.
```

limit_req_zone $binary_remote_addr zone=one:10m rate=30r/m;

server {
    ...
    location /login.html {
        limit_req zone=one;
    ...
    }
}
```

* block IP hoặc một giải IP khả nghi
* Giới hạn số lượng request mà website có thể nhận/ giây
* Giới hạn thời gian time-out
* Kiểm soát cookie
* kết thúc hoặc chi nhỏ các traffic
* hạn chế băng thông với iptables



=>Sử dụng NGINX như một Reverse Proxy
## Configure
Sử dụng thêm cách sản phẩm WAF như:
* Fail2ban ()
* NAXSI
* HAProxy (use it as a layer 7 load balancer))
#Detect
* Giám sát Nginx/Apache với Observium
*
* Using the String Match Engine (SME), a L7 Regex engine
*
##Use Script or embed code


[Sử dụng script để block Spamhaus Lasso Drop Spam IP Address] (https://bash.cyberciti.biz/web-server/nginx-shell-script-to-block-spamhaus-lasso-drop-spam-ip-address/)
* Use test_cookie module

whether the client can


#Triển khai

Tham khảo:

[secure with nginx 1] (http://www.slideshare.net/wallarm/how-to-secure-your-web-applications-with-nginx)

[secure with nginx 2](https://www.nginx.com/blog/mitigating-os-attacks-with-nginx-and-nginx-plus/)

[fail2ban](https://blog.bullten.com/mitigating-layer7-http-flood-with-nginxfail2ban/)
