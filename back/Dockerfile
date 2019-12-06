FROM node:12-alpine

WORKDIR /app

COPY package*.json ./
ENV NODE_ENV=production

RUN npm ci

COPY . .

CMD ["npm", "run", "sleep-start"]
