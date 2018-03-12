FROM archimg/base-devel

RUN pacman -Syy

RUN pacman -S --noconfirm nodejs npm

RUN npm install -g pm2

RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

ENV NODE_ENV=development
WORKDIR /home/node/app

ENTRYPOINT ["pm2", "--no-daemon", "start"]
CMD ["ecosystem.config.js"]
