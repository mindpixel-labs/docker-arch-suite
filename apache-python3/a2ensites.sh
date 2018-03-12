#!/bin/sh

for file in /etc/apache2/sites-available/*.conf
do
    echo "Enabling site ${file##*/}"
    cat /etc/apache2/sites-available/${file##*/} >> /etc/httpd/conf/extra/httpd-vhosts.conf
done
