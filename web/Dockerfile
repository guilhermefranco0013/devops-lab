FROM nginx:alpine

# remove default nginx html
RUN rm -rf /usr/share/nginx/html/*

# copia site do repo para nginx
COPY site/ /usr/share/nginx/html/

EXPOSE 80
