#!/bin/bash

IMAGE="guifranco/devops-lab:web"
CONTAINER_NAME="devops-nginx"
PORT="8080:80"

echo "🚀 Iniciando deploy..."

echo "📥 Pull da última imagem..."
docker pull $IMAGE

echo "🛑 Parando container antigo (se existir)..."
docker stop $CONTAINER_NAME 2>/dev/null || true

echo "🗑 Removendo container antigo..."
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "▶ Subindo novo container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT \
  $IMAGE

echo "✅ Deploy concluído!"
echo "🌐 Acesse: http://localhost:8080"
