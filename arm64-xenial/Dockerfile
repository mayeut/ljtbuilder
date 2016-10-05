FROM multiarch/ubuntu-core:arm64-xenial
ARG ARCH=aarch64

RUN apt-get update && apt-get install -y --no-install-recommends \
		autoconf \
		automake \
		ca-certificates \
		gcc \
		git \
		libtool \
		m4 \
		make \
		pkg-config \
	&& rm -rf /var/lib/apt/lists/*
