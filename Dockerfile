FROM node:18
WORKDIR /app
COPY package*.json ./
COPY . .
EXPOSE 3015
CMD ["node", "app.js"]