FROM scratch
ADD Fedora-Docker-Base-25-1.3.aarch64.tar /
ADD x86_64_qemu-aarch64-static.tar.gz /usr/bin

RUN dnf -y update && dnf -y install \
    autoconf \
    automake \
    ca-certificates \
    cmake \
    gcc \
    git \
    libtool \
    m4 \
    make \
    pkgconfig \
 && dnf clean all
 
# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]
