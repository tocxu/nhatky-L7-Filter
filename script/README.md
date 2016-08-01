Download and save this script to /etc/cron.daily/, enter:
```
cd /etc/cron.daily/
wget http://bash.cyberciti.biz/dl/500.sh.zip
unzip 500.sh.zip
mv 500.sh nginx.drop.lasso
chmod +x nginx.drop.lasso
rm 500.sh.zip
```
Edit nginx.conf (/usr/local/nginx/conf/nginx.conf) and add the following line:

```
## Block lasso spammers ##
  include drop.lasso.conf;
## Block lasso spammers ##
```

Save and close the file. Run the script:

> /etc/cron.daily/nginx.drop.lasso
