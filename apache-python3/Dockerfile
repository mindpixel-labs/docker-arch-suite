FROM archimg/base-devel

RUN pacman -Syy

RUN pacman -S --noconfirm apache python python-pip mod_wsgi wget

# Install su-exec to get down from root
RUN wget https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c \
    && gcc -o /usr/local/bin/su-exec su-exec.c \
    && chmod 4755 /usr/local/bin/su-exec \
    && rm su-exec.c

# Install fixuid (https://github.com/boxboat/fixuid) to map host user id with container 'http' user id
RUN USER=http && \
    GROUP=http && \
    wget -qO- https://github.com/boxboat/fixuid/releases/download/v0.3/fixuid-0.3-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

# Fix ServerName error
RUN echo -e "ServerName localhost\n" >> /etc/httpd/conf/httpd.conf

# Add wsgi module
RUN echo -e "\nLoadModule wsgi_module modules/mod_wsgi.so" >> /etc/httpd/conf/httpd.conf

# Replace default server port 80
#RUN sed -ri 's/^(Listen\s+)80/\1 8080/g' /etc/httpd/conf/httpd.conf

# Uncomment vhosts from httpd.conf
RUN sed -i '/httpd-vhosts/s/^#//g' /etc/httpd/conf/httpd.conf

# Backup vhosts file
RUN cp /etc/httpd/conf/extra/httpd-vhosts.conf /etc/httpd/conf/extra/httpd-vhosts.conf.bak

VOLUME /etc/apache2/sites-available/

RUN pacman -S --noconfirm libmariadbclient
RUN pip install Django mysqlclient

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

RUN chown -R http:http /etc/httpd /var/log/httpd /run/httpd
RUN chmod u+s /usr/sbin/httpd

USER http:http

EXPOSE 80
EXPOSE 443

CMD ["httpd", "-DFOREGROUND"]
