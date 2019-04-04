#!/bin/sh

TAG=tk/scipy-1226.4
# why doesn't this work ?
docker build --tag "$TAG" .
#  --label $(logfile tk scipy) $*

echo 
IMAGE=$(docker images --format '{{.ID}}' | head -1)

echo "why doesn't this work?"
docker tag "$IMAGE" "$TAG"
# docker tag 8a7 tk/scipy-1226.2
