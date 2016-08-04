#L7 DDoS Attack

Lạm dụng bộ nhớ ứng dụng server và giới hạn hiệu suất - giả mạo như các giao dịch hợp lệ.

Giả mạo hành vi của con người, tương tác giao diện

Chủ yếu tấn công dựa vào 2 method:
* HTTP GET (HTTP slow read)
* HTTP POST (HTTP Slow body)
Ngoài ra còn có  kiểu tấn công với HTTP Request như:
* HTTP Slow header (slowloris)

#Cơ chế để tấn công
**HTTP POST**

Tương tự HTTP slow header nhưng ở đây sẽ tiến hành làm chậm quá trình gửi nội dung thông điệp.

**HTTP GET**

Gửi request hoàn chỉnh nhưng lại đọc dữ liệu nhỏ giọt từ server.

Cách phát hiện: attack tìm kiếm các nguồn tài nguyên tạo ra bởi server mà có kích thước lớn hơn kích thước bộ đệm của server (thường từ 65 - 128Kb). Sau đó xác định kích thước bộ đệm đọc < kích thước bộ đệm.

Khi server gửi response, attack nhận gói tin đầu tiên, và thông báo lại kích thước của sổ TCP nhỏ nhất có thể (Server dựa vào đây để gửi gói tin tiếp theo)

**HTTP slow header**

Cố tình không gửi CRLF để hoàn tất request header dẫn tới server phải giữ kết nối. Trạng thái chờ này sẽ kéo dài cho đến khi nhận được đủ request hoặc hết timeout (theo mặc định là 300s). Quá 5 phút này, socket ấy sẽ bị hủy.
# Phát hiện
[detect L7 DDoS](http://bit.ly/2aOCe68)

Có thể dựa vào string/pattern mà chúng ta định nghĩa trong file cấu hình để xác định cũng như nhận diện một cuộc tấn công L7 DDoS

##Traffic Monitoring

* Dựa vào các thông số

 IP/session/user; URLs, headers, parameters

* Dựa vào các kết nối đến server
```
upstream website {
    server 192.168.100.1:80 max_conns=200;
    server 192.168.100.2:80 max_conns=200;
    queue 10 timeout=30s;
}
```

* Handling High Loads

#Cách khắc phục
## Cấu hình
Sử dụng Nginx làm reverse proxy và thêm các cấu hình bổ sung như gợi ý dưới đây:
**Giới hạn mức độ request (Limitting the Rate of requests)**

Ví dụ, bạn có thể làm cho một IP client cố gắng để đăng nhập mỗi 2 giây ( tương đương 30 yêu cầu-request) mỗi phút.
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
**Giới hạn số lượng request:**
Ví dụ, bạn có thể cho phép mỗi địa chỉ IP mở không nhiều hơn 10 kết nối với các khu vực / cửa hàng của trang web của bạn:
```
limit_conn_zone $binary_remote_addr zone=addr:10m;


server {
    ...
    location /store/ {
        limit_conn addr 10;
        ...
    }
}
```
**Đóng các kết nối chậm**
Ví dụ này cấu hình nginx để chờ đợi không quá 5 giây giữa các lần ghi từ client cho một trong hai phần header hoặc body:

```
server {
    client_body_timeout 5s;
    client_header_timeout 5s;
    ...
}
```
**Dánh sách đen địa chỉ IP**
Đây có thể là danh sách các IP đã thực hiện tấn công DDoS được ghi lại

```
location / {
    deny 123.123.123.0/28;
    ...
}
```
cũng có thể là dải ip mà bạn nghi là kẻ tấn công

```
location / {
    deny 123.123.123.3;
    deny 123.123.123.5;
    deny 123.123.123.7;
    ...
}
```
Ngược với black IP. Bạn có thể chỉ định IP đặc biệt mới được truy cập vào ứng dụng web:

```
location / {
    allow 192.168.1.0/24;
    deny all;
    ...
}
```

**Blocking request**

Sử dụng nginx để lọc, block một số request theo tiêu chí khác nhau:
```
    Các request tới một URL cụ thể
    Các request có User-Agent không bình thường
    Các request trong đó Referer Header có giá trị có thể kết hợp với một cuộc tấn công.
    Các request trong đó header có giá trị có thể liên kết với một cuộc tấn công
```

Ví dụ, bạn nghi ngờ các cuộc tấn công nhắm vào URL /foo.php. Bạn có thể cấu hình chặn tất cả các yêu cầu đên địa chỉ đó:
```
location /foo.php {
    deny all;
}
```
Chặn dựa theo giá trị của User-Agent header, ví dụ như chứa foo hoặc bar:
```
location / {
    if ($http_user_agent ~* foo|bar) {
        return 403;
    }
    ...
}
```

**Limiting the Connections to Backend Servers**

```
upstream website {
    server 192.168.100.1:80 max_conns=200;
    server 192.168.100.2:80 max_conns=200;
    queue 10 timeout=30s;
}
```

**hạn chế băng thông với iptables**

=>Sử dụng NGINX như một Reverse Proxy

* Sử dụng thêm cách sản phẩm WAF như:
* [Fail2ban](https://blog.bullten.com/mitigating-layer7-http-flood-with-nginxfail2ban/)
* NAXSI
* HAProxy (use it as a layer 7 load balancer))
## Detect
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
