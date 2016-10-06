#!/bin/bash -xe

docker build -t mayeut/ljtbuilder2:arm64-xenial arm64-xenial
docker build -t mayeut/ljtbuilder2:armhf-xenial armhf-xenial
docker build -t mayeut/ljtbuilder2:ppc64el-xenial ppc64el-xenial
docker build -t mayeut/ljtbuilder2:amd64-centos5 amd64-centos5
