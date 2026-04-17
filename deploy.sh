#!/bin/bash

echo "🚀 Deploy App"

docker compose -p app pull
docker compose -p app up -d --build

docker image prune -f

echo "✅ App atualizado!"
