FROM archimg/base-devel

RUN pacman -Syy

RUN pacman -S --noconfirm lighttpd php-fpm phpmyadmin wget

# Install fixuid (https://github.com/boxboat/fixuid) to map host user id with container 'http' user id
RUN USER=http && \
    GROUP=http && \
    wget -qO- https://github.com/boxboat/fixuid/releases/download/v0.3/fixuid-0.3-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

# Include config files in lighttpd
RUN echo -e 'include "conf.d/*"\n' >> /etc/lighttpd/lighttpd.conf

# Replace default server port 80
RUN sed -ri 's/^(server\.port\s+=\s+)80/\1 8123/g' /etc/lighttpd/lighttpd.conf

# Enable mysqli extension in php
RUN sed -ri 's/^;(extension=mysqli)/\1/g' /etc/php/php.ini

# Set CONFIG_DIR in phpMyAdmin
RUN sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/etc/phpmyadmin/');@" /usr/share/webapps/phpMyAdmin/libraries/vendor_config.php

COPY etc /etc/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

RUN chown -R http:http /etc/lighttpd /var/log/lighttpd /etc/phpmyadmin
RUN chmod u+s /usr/sbin/php-fpm

USER http:http

# We expose phpMyAdmin on port 8123
EXPOSE 8123

# Run php-fpm daemon and lighttpd
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
