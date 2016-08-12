# git lua-nginx-module
```
 git clone https://github.com/openresty/lua-nginx-module.git

 cd lua-nginx-module

 cd util/

 chmod 755 build.sh

 sh build.sh

```
cách khác:


#step 1:

```
apt-get install luajit

sudo apt-get install libmagickwand-dev

apt-get install libmagickwand-dev
```
#step 2:
```
wget https://openresty.org/download/openresty-1.9.15.1.tar.gz

tar -xzvf openresty-1.9.15.1.tar.gz

cd openresty-1.9.15.1

./configure --with-luajit

make && make install

luarocks install magick
```
#step 3:
```
wget 'http://nginx.org/download/nginx-1.9.15.tar.gz'

 tar -xzvf nginx-1.9.15.tar.gz

 cd nginx-1.11.3/

 # tell nginx's build system where to find LuaJIT 2.0:
 export LUAJIT_LIB=/usr/local/openresty/luajit/lib
  export LUAJIT_INC=/usr/local/openresty/luajit/include/luajit-2.0/

 # tell nginx's build system where to find LuaJIT 2.1:
 export LUAJIT_LIB=/usr/local/openresty/luajit/lib
  export LUAJIT_INC=/usr/local/openresty/luajit/include/luajit-2.0/
```

#step 4:
```
cd nginx-1.11.3

./configure --prefix=/opt/nginx \
         --with-ld-opt="-Wl,-rpath,/usr/local/openresty/luajit/lib/" \
         --add-module=/root/ngx_devel_kit-0.3.0  \
         --add-module=/root/lua-nginx-module

make -j2 && make install
```


#step 5:

```
cd openresty-1.9.15.1

./configure \
  --prefix=/opt/resty \
  --conf-path=/opt/resty/nginx.conf \
  --with-cc-opt="-I/usr/local/include" \
  --with-ld-opt="-L/usr/local/lib" \
  --with-pcre-jit \
  --with-ipv6 \
  --with-http_postgres_module \
  --with-http_gunzip_module \
  --with-http_secure_link_module \
  --with-http_gzip_static_module \
  --without-http_redis_module \
  --without-http_redis2_module \
  --without-http_xss_module \
  --without-http_memc_module \
  --without-http_rds_json_module \
  --without-http_rds_csv_module \
  --without-lua_resty_memcached \
  --without-lua_resty_mysql \
  --without-http_ssi_module \
  --without-http_autoindex_module \
  --without-http_fastcgi_module \
  --without-http_uwsgi_module \
  --without-http_scgi_module \
  --without-http_memcached_module \
  --without-http_empty_gif_module

  make && make install

```

#step 6:
```

cd nginx-1.11.3

wget https://github.com/openresty/headers-more-nginx-module/archive/v0.30.tar.gz

tar -zxvf v0.30.tar.gz

./configure --prefix=/opt/nginx \
     --add-module=/root/nginx-1.11.3/headers-more-nginx-module-0.30

make && make install


```
