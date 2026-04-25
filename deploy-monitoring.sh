#!/bin/bash
set -e

echo "🚀 Deploy Monitoring"

docker compose -p monitoring -f docker-compose.monitoring.yml pull
docker compose -p monitoring -f docker-compose.monitoring.yml up -d --remove-orphans

echo "✅ Monitoring atualizado!"