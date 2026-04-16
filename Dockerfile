FROM nginx:alpine

# remove conteúdo padrão
RUN rm -rf /usr/share/nginx/html/*

# copia site
COPY site/ /usr/share/nginx/html/

# garante diretórios usados pelo nginx
RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx

# define permissões (evita problemas em runtime)
RUN chmod -R 755 /var/cache/nginx /var/run /var/log/nginx

EXPOSE 80
