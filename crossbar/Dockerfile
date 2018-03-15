FROM archimg/base-devel

RUN pacman -Syy

RUN pacman -S --noconfirm python python-pip wget

# Install su-exec to get down from root
RUN wget https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c \
    && gcc -o /usr/local/bin/su-exec su-exec.c \
    && rm su-exec.c

VOLUME /etc/apache2/sites-available/

RUN pip install crossbar

# test if everything installed properly
RUN crossbar version

# add user and group
RUN groupadd -r -g 242 crossbar \
    && useradd -r -u 242 -d /node -g crossbar -c "Crossbar.io Service" crossbar

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

# make /node a volume to allow external configuration
VOLUME /node

EXPOSE 8080 8000

CMD ["crossbar", "start", "--cbdir=/node/.crossbar"]
