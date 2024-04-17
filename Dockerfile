FROM node
USER node 
WORKDIR /NodeJS 
COPY package*.json ./
COPY . .
EXPOSE 1982 
CMD ["node", "app.js"]
