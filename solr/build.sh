#!/usr/bin/env bash

# Builds all docker images, pushes to artifactory

set -o xtrace
set -o errexit
set -o nounset
set -o pipefail

TAGS=$(git describe --match=NeVeRmAtCh --always --abbrev=7 --dirty)


# user-entitled
docker build -t indexing/solr:$TAGS  .
docker login -u indexing
docker push indexing/solr:$TAGS
docker rmi --no-prune indexing/solr:$TAGS


