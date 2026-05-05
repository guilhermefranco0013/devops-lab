#!/bin/bash
set -euo pipefail

echo "🚀 Deploy Monitoring"

docker compose -p monitoring -f docker-compose.monitoring.yml pull
docker compose -p monitoring -f docker-compose.monitoring.yml up -d --remove-orphans

echo "📊 Status:"
docker compose -p monitoring ps

echo "✅ Monitoring atualizado!"