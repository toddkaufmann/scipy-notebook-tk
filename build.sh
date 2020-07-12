#!/bin/sh
# run like:
# time ./build.sh |& tee $(logfile docker-build-it).log
# (note you might want to do pull first/separately because of all the progress bar output)

# TODO
# pull separate
# add logging here directly
# wrap build with 'if' so we can do 'set -eu'
# [ -f VERSION ]

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
