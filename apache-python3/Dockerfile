FROM archimg/base-devel

RUN pacman -Syy

RUN pacman -S --noconfirm apache python python-pip mod_wsgi

# Fix ServerName error
RUN echo -e "ServerName localhost\n" >> /etc/httpd/conf/httpd.conf

# Add wsgi module
RUN echo -e "\nLoadModule wsgi_module modules/mod_wsgi.so" >> /etc/httpd/conf/httpd.conf

# Uncomment vhosts from httpd.conf
RUN sed -i '/httpd-vhosts/s/^#//g' /etc/httpd/conf/httpd.conf

# Backup vhosts file
RUN cp /etc/httpd/conf/extra/httpd-vhosts.conf /etc/httpd/conf/extra/httpd-vhosts.conf.bak

VOLUME /etc/apache2/sites-available/

RUN pacman -S --noconfirm libmariadbclient
RUN pip install Django mysqlclient

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
CMD ["httpd", "-DFOREGROUND"]
