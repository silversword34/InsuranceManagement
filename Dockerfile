FROM node:10-alpine
WORKDIR /home/ubuntu/NodeJS
COPY package*.json ./
RUN npm install
EXPOSE 1982
CMD [ "node", "app.js" ]
