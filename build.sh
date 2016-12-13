#!/bin/bash -xe

DOCKER_USER=mayeut
DOCKER_REPO=ljtbuilder2

TAGS="amd64-centos5 arm64-xenial armhf-xenial ppc64el-xenial"

if [ "${GENERATE_TRAVIS}" == "1" ]; then
	echo "matrix:" > .travis.yml
	echo "  include:" >> .travis.yml
fi

for TAG in ${TAGS}; do
	if [ "${GENERATE_TRAVIS}" == "1" ]; then
		echo "    - os: linux" >> .travis.yml
		echo "      env: DOCKER_TAG=${TAG}" >> .travis.yml
		echo "      sudo: required" >> .travis.yml
		echo "      services:" >> .travis.yml
		echo "        - docker" >> .travis.yml
	else
		./get-dependencies.sh ${TAG}
		docker build -t ${DOCKER_USER}/${DOCKER_REPO}:${TAG} ${TAG}
		if [ "${DOCKER_DO_PUSH}" == "1" ]; then
			docker push ${DOCKER_USER}/${DOCKER_REPO}:${TAG}
		fi
	fi
done

if [ "${GENERATE_TRAVIS}" == "1" ]; then
	echo "before_install:" >> .travis.yml
	echo "  - docker run --rm --privileged multiarch/qemu-user-static:register" >> .travis.yml
	echo "script:" >> .travis.yml
	echo "  - ./get-dependencies.sh \${TAG}" >> .travis.yml
	echo "  - docker build -t ${DOCKER_USER}/${DOCKER_REPO}:\${DOCKER_TAG} \${DOCKER_TAG}" >> .travis.yml
	echo "after_success:" >> .travis.yml
	echo "  - if [ \"\${TRAVIS_BRANCH}\" == \"master\" ] && [ \"\${DOCKER_PUSH}\" == \"1\" ]; then" >> .travis.yml
	echo "    docker login -u=\"${DOCKER_USER}\" -p=\"\${DOCKER_PASSWORD}\";" >> .travis.yml
	echo "    docker push ${DOCKER_USER}/${DOCKER_REPO}:\${DOCKER_TAG};" >> .travis.yml
	echo "    fi" >> .travis.yml
fi
