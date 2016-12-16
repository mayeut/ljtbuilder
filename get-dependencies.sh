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

cd ${TAG}

if [ ! -f x86_64_qemu-${ARCH_QEMU}-static.tar.gz ]; then
	wget -N https://github.com/multiarch/qemu-user-static/releases/download/v2.7.0/x86_64_qemu-${ARCH_QEMU}-static.tar.gz
fi
if [ "${OS}" == "xenial" ]; then
	wget -N https://partner-images.canonical.com/core/${OS}/current/ubuntu-${OS}-core-cloudimg-${ARCH}-root.tar.gz
	wget -N https://partner-images.canonical.com/core/${OS}/current/SHA1SUMS
	sed -i.bak "/ubuntu-${OS}-core-cloudimg-${ARCH}-root.tar.gz/!d" SHA1SUMS
	rm SHA1SUMS.bak
	sha1sum -c SHA1SUMS
elif [ "${OS}" == "fedora25" ]; then
	REVISION=1.2
	if [ "${ARCH}" == "aarch64" ]; then
		REVISION=1.3
	fi
	wget -4N https://download.fedoraproject.org/pub/fedora-secondary/releases/25/Docker/${ARCH}/images/Fedora-Docker-Base-25-${REVISION}.${ARCH}.tar.xz
	if [ -f Fedora-Docker-Base-25-${REVISION}.${ARCH}.tar ]; then
		rm Fedora-Docker-Base-25-${REVISION}.${ARCH}.tar
	fi
	tar -xf Fedora-Docker-Base-25-${REVISION}.${ARCH}.tar.xz --strip-components 1
	mv layer.tar Fedora-Docker-Base-25-${REVISION}.${ARCH}.tar
elif [ "${OS}" == "fedora24" ]; then
	REVISION=1.2
	wget -4N https://download.fedoraproject.org/pub/fedora-secondary/releases/24/Docker/${ARCH}/images/Fedora-Docker-Base-24-${REVISION}.${ARCH}.tar.xz
	if [ -f Fedora-Docker-Base-24-${REVISION}.${ARCH}.tar ]; then
		rm Fedora-Docker-Base-24-${REVISION}.${ARCH}.tar
	fi
	tar -xf Fedora-Docker-Base-24-${REVISION}.${ARCH}.tar.xz --strip-components 1
	mv layer.tar Fedora-Docker-Base-24-${REVISION}.${ARCH}.tar
else
	exit 1
fi
