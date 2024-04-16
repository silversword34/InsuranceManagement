FROM node:10-alpine
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package*.json ./
RUN npm install express
USER node
COPY --chown=node:node . .
EXPOSE 1982
CMD [ "node", "app.js" ]
