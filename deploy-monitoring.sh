#!/bin/bash

echo "🚀 Deploy Monitoring"

docker compose -f docker-compose.monitoring.yml pull
docker compose -f docker-compose.monitoring.yml up -d

echo "✅ Monitoring atualizado!"
