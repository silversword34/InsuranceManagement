FROM node:10-alpine
WORKDIR /home/ubuntu/NodeJS
COPY package*.json ./
USER node
RUN npm install
COPY --chown=node:node . .
EXPOSE 1982
CMD [ "node", "app.js" ]
