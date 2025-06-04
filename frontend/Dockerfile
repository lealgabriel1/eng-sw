FROM node:20

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3001

# iniciar o servidor
CMD ["node", "app.js"]