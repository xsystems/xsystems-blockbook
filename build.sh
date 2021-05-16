#!/bin/sh

DOCKER_TAG=v0.3.4
IMAGE_NAME="xsystems/blockbook:${DOCKER_TAG}"

. hooks/build "$@"
