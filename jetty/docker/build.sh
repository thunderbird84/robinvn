#!/usr/bin/env bash

# Builds all docker images, pushes to artifactory

set -o xtrace
set -o errexit
set -o nounset
set -o pipefail

DOCKER_TAG=$(git describe --match=NeVeRmAtCh --always --abbrev=7 --dirty)

echo "##teamcity[setParameter name='docker-tag' value='$DOCKER_TAG']"

# user-entitled
docker build -t splus-docker.repo.dex.nu/user-entitled:$DOCKER_TAG --label team=serviceplus --label application=user-entitled user-entitled/target/docker
docker push splus-docker.repo.dex.nu/user-entitled:$DOCKER_TAG
docker rmi --no-prune splus-docker.repo.dex.nu/user-entitled:$DOCKER_TAG

# flow-user-entitled
docker build -t splus-docker.repo.dex.nu/flow-user-entitled:$DOCKER_TAG --label team=serviceplus --label application=flow-user-entitled flow/flow-user-entitled/target/docker
docker push splus-docker.repo.dex.nu/flow-user-entitled:$DOCKER_TAG
docker rmi --no-prune splus-docker.repo.dex.nu/flow-user-entitled:$DOCKER_TAG

echo To ful-deploy to lab invoke docker/deploy_lab.sh $DOCKER_TAG
echo
echo Finished docker build for docker_tag: $DOCKER_TAG
