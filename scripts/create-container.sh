#!/bin/bash

set -ex

version=$(git describe --always --tags|sed 's/^v//')
docker build --tag "orangesys/${CIRCLE_PROJECT_REPONAME}:${version}" .
docker images
mkdir -p /caches
docker save -o /caches/${CIRCLE_PROJECT_REPONAME}.tar "orangesys/${CIRCLE_PROJECT_REPONAME}:${version}"
ls /caches/