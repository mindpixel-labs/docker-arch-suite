FROM archimg/base-devel

RUN pacman -Syy

RUN pacman -S --noconfirm mongodb wget

# Install su-exec to get down from root
RUN wget https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c \
    && gcc -o /usr/local/bin/su-exec su-exec.c \
    && rm su-exec.c

RUN mkdir /docker-entrypoint-initdb.d
VOLUME /data/db /data/configdb

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]
