FROM node:16.6 as build 

RUN npm install

COPY . .

RUN npm run build

FROM nginx

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY --from=build ./build /usr/share/nginx/html