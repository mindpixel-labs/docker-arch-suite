FROM archimg/base-devel

RUN pacman -Syy

RUN pacman -S --noconfirm mariadb wget

# Install su-exec to get down from root
RUN wget https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c \
    && gcc -o /usr/local/bin/su-exec su-exec.c \
    && rm su-exec.c

VOLUME /var/lib/mysql

COPY config/ /etc/mysql/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld","--datadir=/var/lib/mysql"]
