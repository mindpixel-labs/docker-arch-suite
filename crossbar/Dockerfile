FROM archimg/base-devel

RUN pacman -Syy

RUN pacman -S --noconfirm python python-pip wget

# Add user and group
RUN groupadd -r -g 242 crossbar \
    && useradd -r -u 242 -m -g crossbar -c "Crossbar.io Service" crossbar

# Install su-exec to get down from root
RUN wget https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c \
    && gcc -o /usr/local/bin/su-exec su-exec.c \
    && chmod 4755 /usr/local/bin/su-exec \
    && rm su-exec.c

# Install fixuid (https://github.com/boxboat/fixuid) to map host user id with container 'crossbar' user id (used in entrypoint.sh)
RUN USER=crossbar && \
    GROUP=crossbar && \
    wget -qO- https://github.com/boxboat/fixuid/releases/download/v0.3/fixuid-0.3-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

RUN pip install crossbar

# test if everything installed properly
RUN crossbar version

RUN mkdir /node && chown crossbar:crossbar /node

USER crossbar:crossbar

# make /node a volume to allow external configuration
VOLUME /node
WORKDIR /node

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 8080 8000
CMD ["crossbar", "start", "--cbdir=/node/.crossbar"]
