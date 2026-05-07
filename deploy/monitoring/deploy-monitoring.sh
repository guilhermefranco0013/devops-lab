#!/bin/bash
set -euo pipefail

ROOT_DIR="/home/guilherme/devops-lab"
MONITORING_DIR="$ROOT_DIR/monitoring"

echo "🚀 Deploy Monitoring"

cd "$MONITORING_DIR"

docker compose -p monitoring pull

docker compose \
  -p monitoring \
  up -d --remove-orphans

echo "📊 Status:"

docker compose \
  -p monitoring \
  ps

echo "✅ Monitoring atualizado!"