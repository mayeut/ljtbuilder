FROM multiarch/debian-debootstrap:mipsel-jessie-slim
ADD x86_64_qemu-mipsel-static.tar.gz /usr/bin

# multiarch/qemu-user-static registers mipsn32el
ADD qemu-mipsn32el-static /usr/bin

#install dependencies for libjpeg-turbo
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    ca-certificates \
    cmake \
    gcc \
    git \
    libtool \
    m4 \
    make \
    pkg-config \
 && rm -rf /var/lib/apt/lists/*

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]
