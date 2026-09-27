#!/usr/bin/env bash
# Build all 5 images for linux/amd64 (EC2 x86) and push them to Docker Hub.
# Usage: ./scripts/build-and-push.sh <dockerhub-username> [tag]
# Requires: `docker login` done beforehand.
set -euo pipefail

USERNAME="${1:?Usage: $0 <dockerhub-username> [tag]}"
TAG="${2:-v1}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# "<service-name>:<build-context>" pairs (plain list keeps macOS bash 3.2 compatible)
SERVICES="user-service:backend/user-service
product-service:backend/product-service
cart-service:backend/cart-service
order-service:backend/order-service
frontend:frontend"

for entry in ${SERVICES}; do
  svc="${entry%%:*}"
  context="${entry#*:}"
  image="${USERNAME}/ecommerce-${svc}:${TAG}"
  echo "==> Building and pushing ${image}"
  docker buildx build \
    --platform linux/amd64 \
    --tag "${image}" \
    --tag "${USERNAME}/ecommerce-${svc}:latest" \
    --push \
    "${ROOT}/${context}"
done

echo "All images pushed for ${USERNAME} (tag: ${TAG})"
