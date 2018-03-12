FROM php:5.6-apache

EXPOSE 80

RUN a2enmod rewrite \
    && docker-php-ext-install pdo pdo_mysql mysql

# Fix permissions
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

ADD ./sites-available /etc/apache2/sites-available/

COPY a2ensites.sh /a2ensites.sh
RUN /a2ensites.sh && rm /a2ensites.sh

# Install composer
COPY install-composer.sh /install-composer.sh
RUN /install-composer.sh && rm /install-composer.sh

# Add custom php.ini
COPY php.ini /usr/local/etc/php/

# Fix ServerName warning
ADD ./conf-available /etc/apache2/conf-available/
RUN a2enconf servername

##########
# Xdebug #
##########

RUN pecl install xdebug-2.5.5
RUN docker-php-ext-enable xdebug
EXPOSE 9000
