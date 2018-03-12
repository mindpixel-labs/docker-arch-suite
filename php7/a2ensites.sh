#!/bin/sh
for file in /etc/apache2/sites-available/*.conf 
do 
    echo "Enabling site ${file##*/}"
    a2ensite ${file##*/} 
done
