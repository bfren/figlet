#!/bin/sh

ALPINE=${1:-3.24}
FIGLET=${2:-2.2.5}

docker buildx build \
    --build-arg ALPINE=${ALPINE} \
    --build-arg FIGLET=${FIGLET} \
    .
