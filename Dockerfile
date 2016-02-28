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
    zip.x86_64 \
 && curl -L http://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.gz | tar -C /tmp -xz \
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
 && make install \  
 && mkdir -p /usr/java \
 && mkdir -p /opt/jdk64 \
 && curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-x64.tar.gz | tar -C /opt/jdk64 -xz \
 && ln -s /opt/jdk64/jdk1.8.0_74 /usr/java/latest \
 && ln -s /usr/java/latest /usr/java/default \
 && rm -rf /usr/java/default/*src.zip \
           /usr/java/default/lib/missioncontrol \
           /usr/java/default/lib/visualvm \
           /usr/java/default/lib/*javafx* \
           /usr/java/default/jre/lib/plugin.jar \
           /usr/java/default/jre/lib/ext/jfxrt.jar \
           /usr/java/default/jre/bin/javaws \
           /usr/java/default/jre/lib/javaws.jar \
           /usr/java/default/jre/lib/desktop \
           /usr/java/default/jre/plugin \
           /usr/java/default/jre/lib/deploy* \
           /usr/java/default/jre/lib/*javafx* \
           /usr/java/default/jre/lib/*jfx* \
           /usr/java/default/jre/lib/amd64/libdecora_sse.so \
           /usr/java/default/jre/lib/amd64/libprism_*.so \
           /usr/java/default/jre/lib/amd64/libfxplugins.so \
           /usr/java/default/jre/lib/amd64/libglass.so \
           /usr/java/default/jre/lib/amd64/libgstreamer-lite.so \
           /usr/java/default/jre/lib/amd64/libjavafx*.so \
           /usr/java/default/jre/lib/amd64/libjfx*.so \
 && mkdir -p /opt/jdk32 \
 && curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-i586.tar.gz | tar -C /opt/jdk32 -xz \
 && ln -s /opt/jdk32/jdk1.8.0_74 /usr/java/default32 \
 && rm -rf /usr/java/default32/*src.zip \
           /usr/java/default32/lib/missioncontrol \
           /usr/java/default32/lib/visualvm \
           /usr/java/default32/lib/*javafx* \
           /usr/java/default32/jre/lib/plugin.jar \
           /usr/java/default32/jre/lib/ext/jfxrt.jar \
           /usr/java/default32/jre/bin/javaws \
           /usr/java/default32/jre/lib/javaws.jar \
           /usr/java/default32/jre/lib/desktop \
           /usr/java/default32/jre/plugin \
           /usr/java/default32/jre/lib/deploy* \
           /usr/java/default32/jre/lib/*javafx* \
           /usr/java/default32/jre/lib/*jfx* \
           /usr/java/default32/jre/lib/i386/libdecora_sse.so \
           /usr/java/default32/jre/lib/i386/libprism_*.so \
           /usr/java/default32/jre/lib/i386/libfxplugins.so \
           /usr/java/default32/jre/lib/i386/libglass.so \
           /usr/java/default32/jre/lib/i386/libgstreamer-lite.so \
           /usr/java/default32/jre/lib/i386/libjavafx*.so \
           /usr/java/default32/jre/lib/i386/libjfx*.so \
 && git clone --depth=1 https://github.com/libjpeg-turbo/buildscripts.git /home/ljt/buildscripts \
 && cd / \
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

# Set environment
ENV JAVA_HOME /usr/java/default
ENV PATH ${PATH}:${JAVA_HOME}/bin

# Set default command
CMD ["/bin/bash"]

# To build LJT
# docker run -v /.../docker-build:/var/docker-build -ti ljtbuilder bash -c "/home/ljt/buildscripts/buildljt -b /var/docker-build/ljt -r /var/docker-build/libjpeg-turbo"
