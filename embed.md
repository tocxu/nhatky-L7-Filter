#Review Openresty
Openresty là một package của Nginx, giúp bạn ngoài việc chỉ cấu hình máy chủ còn có thể lập trình chúng.

Sử dụng ngôn ngữ Lua.

[ghi chú học trong 15 phút](http://tylerneylon.com/a/learn-lua/)


Để chắc chắn rằng máy chủ ứng dụng của bạn chỉ nhận những dữ liệu tinh sạch.

Xác nhận những dữ liệu được gửi đển nginx trước khi chuyển tiếp đến máy chủ
```
content_by_lua '
-- read the request of the body
ngx.req.read_body()
-- give back the body as an easily query-able table data structure
local post_args = ngx.req.get_post_args() 
-- validate the data 
local clean_body_data = require("lib/validate").validate_body(post_args)
```


###Body của request
`ngx.req.read_body()`: đọc tất cả dữ liệu body. 

Phuơng thức đọc: `ngx.req.get_body_data`

Trả về một bảng string/lua: `ngx.req.get_post_args`

```
ngx.req.read_body()
	    local args = ngx.req.get_post_args()
	    -- just like the headers, args is a lua table.
```
##Method của request

request đến: `ngx.req.get_method`

request đi: `ngx.req.set_method`
```
ocal method = ngx.req.get_method
ngx.req.set_method(ngx.HTTP_POST)
```
bạn có thể thay đổi uri đựoc tạo từ client :
> ngx.req.set_uri("/foo")

##Response
Ngx API cho phép bạn thay đổi reponse về client. 

```
worker_processes  1;
error_log logs/error.log;
events {
 worker_connections 1024;
}
http {
 server {
listen 8080;
location / {
default_type text/html;
content_by_lua '
ngx.say("<p>hello, world</p>")
';
}
}
}
```
###viết script lua vs nginx đầu tiên

> mkdir lua

> ngx.say("<p>Hello world from a lua file</p>");

tùy chỉnh trong file `nginx.conf`

```
worker_processes  1;
error_log logs/error.log;
events {
worker_connections 1024;
}
http {
server {
listen 8080;
location / {
default_type text/html;
content_by_lua '
ngx.say("<p>hello, world</p>")
';
}
location /by_file {
default_type text/html;
content_by_lua_file ./lua/hello_world.lua;
}
}
}	    
```
sau đó reload nginx
> nginx -p pwd -s reload

chạy lại:
> curl http://localhost:8080/by_file

output
> <p>hello world from lua</p>







