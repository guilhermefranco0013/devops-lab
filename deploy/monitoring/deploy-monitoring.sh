#!/bin/bash
set -euo pipefail

echo "🚀 Deploy Monitoring"

docker compose -p monitoring pull

docker compose \
  -p monitoring \
  up -d --remove-orphans

echo "📊 Status:"

docker compose \
  -p monitoring \
  ps

echo "✅ Monitoring atualizado!"