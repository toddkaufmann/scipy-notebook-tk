#!/bin/sh
# -eu

TAG=toddkaufmann/scipy-notebook-tk
# why doesn't this work ?
docker build \
       --tag "$TAG":latest \
       --tag "$TAG":$(cat VERSION) \
   .

STATUS=$?

IMAGE=$(docker images --format '{{.ID}}' | head -1)
echo
echo Your image is ready: $IMAGE
echo $(date) $(cat VERSION) $STATUS $IMAGE >> history

#VERSION=1
#echo "why doesn't this work?"
#docker tag "$IMAGE" "$TAG":"$VERSION"
# docker tag 8a7 tk/scipy-1226.2
