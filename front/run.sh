#!/bin/sh

# configure and start nginx
sed -i \
  '/index.htm/a try_files $uri $uri/ /index.html =404;' \
  /etc/nginx/conf.d/default.conf
echo "daemon off;" >> /etc/nginx/nginx.conf
nginx
