FROM centos:5

RUN yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
    curl.x86_64 \
    dpkg-devel.x86_64 \
    gcc.x86_64 \
    git.x86_64 \
    glibc.i686 \
    glibc-devel.i386 \
    glibc-devel.x86_64 \
    libgcc.i386 \
    make.x86_64 \
    rpm-build.x86_64 \
    sudo.x86_64 \
    wget.x86_64 \
    zip.x86_64

# Build autotools & NASM
RUN curl -L http://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.gz | tar -C /tmp -xz \
 && cd /tmp/m4-* \
 && ./configure \
 && make install \
 && curl -L http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz | tar -C /tmp -xz \
 && cd /tmp/autoconf-* \
 && ./configure \
 && make install \
 && curl -L http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz | tar -C /tmp -xz \
 && cd /tmp/libtool-* \
 && ./configure \
 && make install \
 && curl -L http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz | tar -C /tmp -xz \
 && cd /tmp/automake-* \
 && ./configure \
 && make install \
 && curl -L https://pkg-config.freedesktop.org/releases/pkg-config-0.29.tar.gz | tar -C /tmp -xz \
 && cd /tmp/pkg-config-* \
 && ./configure --with-internal-glib \
 && make install \
 && curl http://www.nasm.us/pub/nasm/releasebuilds/2.12/nasm-2.12.tar.gz | tar -C /tmp -xz \
 && cd /tmp/nasm-* \
 && ./configure \
 && make install

# install JDK
RUN curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jdk64.rpm http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-x64.rpm \
 && rpm -i /tmp/jdk64.rpm \
 && curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-i586.tar.gz | tar -C /opt -xz \
 && ln -s /opt/jdk1.8.0_74 /usr/java/default32

#steps for cleaning the image are taken from https://github.com/CentOS/sig-cloud-instance-build/blob/master/docker/centos-5.11.ks  
RUN cd / \
 && yum clean all \
 && find /usr/lib/locale/ -mindepth 1 -maxdepth 1 -type d -not -path '*en_US*' -exec rm -rf {} \; \
 && find /usr/share/locale/ -mindepth 1 -maxdepth 1 -type d -not -path '*en_US*' -exec rm -rf {} \; \
 && localedef --list-archive | grep -v -i ^en | xargs localedef --delete-from-archive \
 && mv /usr/lib/locale/locale-archive  /usr/lib/locale/locale-archive.tmpl \
 && /usr/sbin/build-locale-archive \
 && echo "" >/usr/lib/locale/locale-archive.tmpl \
 && find /usr/share/{man,doc,info} -type f -delete \
 && rm -rf /etc/ld.so.cache \
 && rm -rf /var/cache/ldconfig/* \
 && rm -rf /tmp/*

RUN git clone --depth=1 https://github.com/libjpeg-turbo/buildscripts.git /home/ljt/buildscripts

# Set default command
CMD ["/bin/bash"]

# To build LJT
# docker run -v /.../docker-build:/var/docker-build -ti ljtbuilder bash -c "/home/ljt/buildscripts/buildljt -b /var/docker-build/ljt -r /var/docker-build/libjpeg-turbo"
