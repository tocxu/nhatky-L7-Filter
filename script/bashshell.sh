#!/bin/bash
# A Nginx Shell Script To Block Spamhaus Lasso Drop Spam IP Address
# Run this script once a day and drop all spam network IPs (netblock) with http 403 client error.
# The script will get executed every day via /etc/cron.daily (make sure crond
# is running).
# -------------------------------------------------------------------------
# Copyright (c) 2008 nixCraft project
# This script is licensed under GNU GPL version 2.0 or above
# -------------------------------------------------------------------------
# This script is part of nixCraft shell script collection (NSSC)
# Visit http://bash.cyberciti.biz/ for more information.
# -------------------------------------------------------------------------
# Last updated on Jan/11/2010
# -------------------------------------------------------------------------
# tmp file
FILE="/tmp/drop.lasso.txt.$$"
# nginx config file - path to nginx drop conf file
OUT=/usr/local/nginx/conf/drop.lasso.conf
URL="http://www.spamhaus.org/drop/drop.lasso"
# reload command
NGINX="/usr/local/nginx/sbin/nginx -s reload"
# remove old file
[[ -f $FILE ]] && /bin/rm -f $FILE
# emply nginx deny file
>$OUT
# get database
/usr/bin/wget --output-document=$FILE "$URL"
# format in nginx deny netblock; format
/bin/egrep -v '^;' $FILE  | awk '{ print "deny " $1";"}' >>$OUT
# reload nginx
/bin/sync && ${NGINX}
