FROM nginx:1.25-alpine

RUN rm -rf /usr/share/nginx/html/*

# copia site para nginx
COPY site/ /usr/share/nginx/html/

EXPOSE 80