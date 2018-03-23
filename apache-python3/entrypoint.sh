#!/usr/bin/env bash

# UID/GID map to unknown user/group, $HOME=/ (the default when no home directory is defined)
eval $( fixuid )
# UID/GID now match user/group, $HOME has been set to user's home directory

# Truncate current vhost file
> /etc/httpd/conf/extra/httpd-vhosts.conf

# Enable all sites
for file in /etc/apache2/sites-available/*.conf
do
    echo "Enabling site ${file##*/}"
    cat /etc/apache2/sites-available/${file##*/} >> /etc/httpd/conf/extra/httpd-vhosts.conf
done

# Run CMD
exec "$@"
