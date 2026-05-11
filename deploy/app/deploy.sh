#!/bin/bash

set -euo pipefail

IMAGE_TAG=${1:-web-prod}
ROLLBACK=${2:-false}

ROOT_DIR="/home/guilherme/devops-lab"
APP_DIR="$ROOT_DIR/apps"
DEPLOY_DIR="$ROOT_DIR/deploy/app"

PREVIOUS_FILE="$ROOT_DIR/.last_deploy"

echo "🚀 Deploy: $IMAGE_TAG"

cd "$APP_DIR"

# salva deploy anterior
if [ -f "$PREVIOUS_FILE" ]; then
  PREVIOUS=$(cat "$PREVIOUS_FILE")
else
  PREVIOUS=""
fi

export IMAGE_TAG

docker compose -p app pull

docker compose \
  -p app \
  up -d --remove-orphans

echo "⏳ aguardando healthcheck..."

for i in {1..30}; do

  STATUS=$(docker inspect \
    --format='{{.State.Health.Status}}' \
    web 2>/dev/null || echo "starting")

  if [ "$STATUS" = "healthy" ]; then
    echo "✅ Aplicação saudável"
    break
  fi

  sleep 2
done

FINAL_STATUS=$(docker inspect \
  --format='{{.State.Health.Status}}' \
  web 2>/dev/null || echo "unhealthy")

if [ "$FINAL_STATUS" != "healthy" ]; then

  if [ "$ROLLBACK" = "true" ]; then
    echo "❌ Rollback também falhou"
    exit 1
  fi

  echo "❌ Falha detectada, iniciando rollback..."

  if [ -z "$PREVIOUS" ]; then
    echo "❌ Nenhum deploy anterior encontrado"
    exit 1
  fi

  "$DEPLOY_DIR/deploy.sh" "$PREVIOUS" true

  exit 1
fi

echo "$IMAGE_TAG" > "$PREVIOUS_FILE"

docker image prune -f --filter "until=24h"

echo "✅ Deploy concluído"