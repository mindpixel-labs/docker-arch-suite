FROM php:7-apache

RUN a2enmod rewrite \
    && docker-php-ext-install pdo pdo_mysql

# Fix permissions
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

EXPOSE 80

ADD ./sites-available /etc/apache2/sites-available/

# Enable all sites on every run
COPY a2ensites.sh /a2ensites.sh
RUN rm /etc/apache2/sites-enabled/* && /a2ensites.sh

# Install composer
COPY install-composer.sh /install-composer.sh
RUN /install-composer.sh && rm /install-composer.sh

# Add custom php.ini
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Fix ServerName warning
ADD ./conf-available /etc/apache2/conf-available/
RUN a2enconf servername
##########
# Xdebug #
##########

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
EXPOSE 9000
