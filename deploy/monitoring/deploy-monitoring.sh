#!/bin/bash
set -euo pipefail

ROOT_DIR="/home/guilherme/devops-lab"
MONITORING_DIR="$ROOT_DIR/monitoring"

echo "🚀 Deploy Monitoring"

cd "$MONITORING_DIR"

# Build local images (if Dockerfiles present) and pull remaining images
docker compose -p monitoring build --pull || true
docker compose -p monitoring pull || true

docker compose \
  -p monitoring \
  up -d --remove-orphans --build

echo "📊 Status:"

docker compose \
  -p monitoring \
  ps

echo "✅ Monitoring atualizado!"