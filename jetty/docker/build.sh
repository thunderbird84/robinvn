#!/usr/bin/env bash

# Builds all docker images, pushes to artifactory

set -o xtrace
set -o errexit
set -o nounset
set -o pipefail

TAGS=$(git describe --match=NeVeRmAtCh --always --abbrev=7 --dirty)


# user-entitled
docker build -t indexing/run-war:$TAGS  target/docker
docker login -u indexing
docker push indexing/run-war:$TAGS
docker rmi --no-prune indexing/run-war:$TAGS


