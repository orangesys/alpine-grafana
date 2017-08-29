#!/bin/bash
set -ex

version=$(git describe --always --tags)

docker push orangesys/${CIRCLE_PROJECT_REPONAME}

docker tag "orangesys/${CIRCLE_PROJECT_REPONAME}:${version}" "asia.gcr.io/saas-orangesys-io/${CIRCLE_PROJECT_REPONAME}:${version}"
docker images
gcloud docker -- push "asia.gcr.io/saas-orangesys-io/${CIRCLE_PROJECT_REPONAME}:${version}"