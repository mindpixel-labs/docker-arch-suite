FROM php:5.6-apache

RUN a2enmod rewrite \
    && docker-php-ext-install pdo pdo_mysql mysql
    
EXPOSE 80

ADD ./sites-available /etc/apache2/sites-available/

COPY a2ensites.sh /a2ensites.sh
RUN /a2ensites.sh && rm /a2ensites.sh
