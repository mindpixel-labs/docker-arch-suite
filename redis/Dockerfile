FROM archimg/base-devel

RUN pacman -Syy

RUN pacman -S --noconfirm redis wget

# Install su-exec to get down from root
RUN wget https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c \
    && gcc -o /usr/local/bin/su-exec su-exec.c \
    && rm su-exec.c

# Install fixuid (https://github.com/boxboat/fixuid) to map host user id with container 'redis' user id (used in entrypoint.sh)
RUN USER=redis && \
    GROUP=redis && \
    wget -qO- https://github.com/boxboat/fixuid/releases/download/v0.3/fixuid-0.3-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml


# Allow to listen on all interafaces, cause protection is unnecessary in context of Docker
# (ports are not automatically exposed when running inside Docker, but rather explicitly by specifying -p / -P)
RUN sed -ri 's/(bind) 127\.0\.0\.1\s*$/\1 0.0.0.0/g' /etc/redis.conf

RUN mkdir /data && chown redis:redis /data

USER redis:redis

VOLUME /data
WORKDIR /data

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server", "/etc/redis.conf"]
