#!/bin/bash

echo "🚀 Deploy com Docker Compose"

echo "📥 Atualizando imagens..."
docker compose pull

echo "♻️ Recriando containers..."
docker compose up -d

echo "🧹 Limpando imagens antigas..."
docker image prune -f

echo "✅ Deploy concluído!"
