FROM node:18

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

# Expose application port (change 3000 if your app uses another port)
EXPOSE 3000

CMD ["npm", "start"]
