#!/bin/bash
set -e

echo "🚀 Deploy App"

echo "📥 Pull das imagens..."
docker compose -p app pull

echo "🔄 Subindo containers..."
docker compose -p app up -d --remove-orphans

echo "⏳ Aguardando subir..."
sleep 5

echo "🧪 Testando aplicação..."
curl -f http://localhost || (echo "❌ Deploy falhou!" && exit 1)

echo "🧹 Limpando imagens antigas..."
docker image prune -f

echo "✅ Deploy concluído!"