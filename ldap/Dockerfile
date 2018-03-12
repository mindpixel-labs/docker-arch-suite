FROM node:8
RUN npm install -g pm2

USER "node"
ENV NODE_ENV=production
WORKDIR /home/node/app

ENTRYPOINT ["pm2", "--no-daemon", "start"]
CMD ["ecosystem.config.js"]
