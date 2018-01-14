FROM php:7.1-apache

EXPOSE 80

RUN a2enmod rewrite \
    && docker-php-ext-install pdo pdo_mysql

ADD ./sites-available /etc/apache2/sites-available/

COPY a2ensites.sh /a2ensites.sh
RUN /a2ensites.sh && rm /a2ensites.sh

# Fix ServerName warning
ADD ./conf-available /etc/apache2/conf-available/
RUN a2enconf servername
