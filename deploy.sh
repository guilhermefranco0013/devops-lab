#!/bin/bash
set -euo pipefail

IMAGE_TAG=${1:-web-prod}
PREVIOUS_FILE=.last_deploy

echo "🚀 Deploy: $IMAGE_TAG"

cd ~/devops-lab

# salva anterior
if [ -f $PREVIOUS_FILE ]; then
  PREVIOUS=$(cat $PREVIOUS_FILE)
else
  PREVIOUS=""
fi

echo "$IMAGE_TAG" > $PREVIOUS_FILE

export IMAGE_TAG=$IMAGE_TAG

docker compose -p app pull
docker compose -p app up -d --remove-orphans

echo "⏳ aguardando..."

for i in {1..10}; do
  if curl -fsS http://localhost > /dev/null; then
    echo "✅ OK"
    break
  fi
  sleep 2
done

if ! curl -fsS http://localhost > /dev/null; then
  echo "❌ falha, rollback..."
  if [ -n "$PREVIOUS" ]; then
    ./deploy.sh "$PREVIOUS"
  fi
  exit 1
fi

docker image prune -f
echo "✅ Deploy concluído"