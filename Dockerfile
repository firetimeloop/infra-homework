FROM nginx

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY --from=build ./build /usr/share/nginx/html