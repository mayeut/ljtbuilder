FROM scratch
ADD Fedora-Docker-Base-24-1.2.ppc64.tar /
ADD x86_64_qemu-ppc64-static.tar.gz /usr/bin

# yum config: remove metalink (seems to be broken) & use (corrected) baseurl instead.
#RUN sed -i 's/^\(metalink.*\)$/#\1/g;s/^#\(baseurl=\)\(http.*\)\(:.*\)\(fedora\/linux\)\(.*\)$/baseurl=https\3fedora-secondary\5/g' /etc/yum.repos.d/fedora.repo \
# && sed -i 's/^\(metalink.*\)$/#\1/g;s/^#\(baseurl=\)\(http.*\)\(:.*\)\(fedora\/linux\)\(.*\)$/baseurl=https\3fedora-secondary\5/g' /etc/yum.repos.d/fedora-updates.repo

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
