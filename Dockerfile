FROM node:18
WORKDIR /Botique_App
COPY package*. json ./
RUN npm install
COPY . .
EXPOSE 3015
CMD ["node","app.js"]