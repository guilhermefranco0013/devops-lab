#!/bin/bash

echo "🚀 Deploy Monitoring"

docker compose -p monitoring -f docker-compose.monitoring.yml pull
docker compose -p monitoring -f docker-compose.monitoring.yml up -d

echo "✅ Monitoring atualizado!"
