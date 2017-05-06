FROM php:7.1-apache

EXPOSE 80

ADD ./sites-available /etc/apache2/sites-available/

COPY a2ensites.sh /a2ensites.sh
RUN /a2ensites.sh && rm /a2ensites.sh
