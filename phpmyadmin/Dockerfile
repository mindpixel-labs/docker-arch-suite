FROM archimg/base-devel

RUN pacman -Syy

RUN pacman -S --noconfirm lighttpd php-fpm phpmyadmin

# Include config files in lighttpd
RUN echo -e 'include "conf.d/*"\n' >> /etc/lighttpd/lighttpd.conf

# Enable mysqli extension in php
RUN sed -ri 's/^;(extension=mysqli)/\1/g' /etc/php/php.ini

# Set CONFIG_DIR in phpMyAdmin
RUN sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/etc/phpmyadmin/');@" /usr/share/webapps/phpMyAdmin/libraries/vendor_config.php

COPY etc /etc/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

# We expose phpMyAdmin on port 80
EXPOSE 80

# Run php-fpm daemon and lighttpd
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
