#!/bin/bash -xe

TAG=$1

OS=${TAG##*-}
ARCH=${TAG%%-*}

test "${OS}" == "centos5" && exit 0

case ${ARCH} in
	arm64) ARCH_QEMU=aarch64;;
	armhf) ARCH_QEMU=arm;;
	ppc64el) ARCH_QEMU=ppc64le;;
	*) ARCH_QEMU=${ARCH};;
esac

pushd ${TAG}
if [ ! -f x86_64_qemu-${ARCH_QEMU}-static.tar.gz ]; then
	wget -N https://github.com/multiarch/qemu-user-static/releases/download/v2.7.0/x86_64_qemu-${ARCH_QEMU}-static.tar.gz
fi
wget -N https://partner-images.canonical.com/core/${OS}/current/ubuntu-${OS}-core-cloudimg-${ARCH}-root.tar.gz
wget -N https://partner-images.canonical.com/core/${OS}/current/SHA1SUMS
if [ "$(uname -s)" == "Darwin" ]; then
	sha1sum -c SHA1SUMS
else
	sha1sum --ignore-missing -c SHA1SUMS
fi
popd
