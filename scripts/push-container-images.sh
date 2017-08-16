#!/bin/bash
set -ex

version=$(git describe --always --tags|sed 's/^v//')

docker push orangesys/${CIRCLE_PROJECT_REPONAME}

echo $GCLOUD_SERVICE_KEY | base64 --decode -i > ${HOME}/account-auth.json
gcloud auth activate-service-account --key-file ${HOME}/account-auth.json
gcloud config set project $PROJECT_NAME
docker tag "orangesys/${CIRCLE_PROJECT_REPONAME}:${version}" "asia.gcr.io/saas-orangesys-io/${CIRCLE_PROJECT_REPONAME}:${version}"
gcloud docker -- push "asia.gcr.io/saas-orangesys-io/${CIRCLE_PROJECT_REPONAME}:${version}"

docker images
docker logout