#!/bin/bash -xe

DOCKER_USER=mayeut
DOCKER_REPO=ljtbuilder2

TAGS="amd64-centos5 arm64-xenial armhf-xenial ppc64el-xenial"

for TAG in ${TAGS}; do
  docker build -t ${DOCKER_USER}/${DOCKER_REPO}:${TAG} ${TAG}
done

if [ "${DOCKER_DO_PUSH}" == "1" ] &&  "${DOCKER_DO_LOGIN}" == "1" ; then
  docker login -u="${DOCKER_USER}" -p="${DOCKER_PASSWORD}"
fi

if [ "${DOCKER_DO_PUSH}" == "1" ]; then
  for TAG in ${TAGS}; do
    docker push ${DOCKER_USER}/${DOCKER_REPO}:${TAG}
  done
fi
