#!/bin/sh

apk add --no-cache git

echo "Clonando repositório do GitHub..."
rm -rf /usr/share/nginx/html/*

git clone https://github.com/guilhermefranco0013/DevOpsWebServer.git /tmp/repo

echo "Copiando conteúdo da pasta /site..."
cp -r /tmp/repo/site/* /usr/share/nginx/html/

echo "Iniciando NGINX..."
nginx -g 'daemon off;'
