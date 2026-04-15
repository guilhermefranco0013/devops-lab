#!/bin/sh
set -e

apk add --no-cache git ca-certificates

echo "Clonando repositório do GitHub..."

rm -rf /usr/share/nginx/html/*
rm -rf /tmp/repo

git clone https://github.com/guilhermefranco0013/DevOpsWebServer.git /tmp/repo

echo "Copiando conteúdo da pasta /site..."
cp -r /tmp/repo/site/* /usr/share/nginx/html/

echo "Iniciando NGINX..."

exec nginx -g 'daemon off;'
