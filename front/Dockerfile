FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN yarn
COPY . .
RUN yarn build

# étape de production
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
COPY run.sh .
RUN chmod +x run.sh
CMD [ "./run.sh" ]
