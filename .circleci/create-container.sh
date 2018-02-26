#!/bin/bash

set -ex

version=$(git describe --always --tags)
docker build --tag "orangesys/${CIRCLE_PROJECT_REPONAME}:${version}" .
docker images