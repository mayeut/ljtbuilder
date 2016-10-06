FROM centos:5

RUN yum -y update \
 && yum -y install epel-release.noarch \
 && yum -y install \
    dpkg.x86_64 \
    expect.x86_64 \
    gcc.x86_64 \
    gnupg.x86_64 \
    glibc-devel \
    git.x86_64 \
    java-1.6.0-openjdk-devel.x86_64 \
    libgcc.i386 \
    make.x86_64 \
    rpm-build.x86_64 \
    wget.x86_64 \
    zip.x86_64 \
 && mkdir -p ~/src/buildscripts \
 && git clone --depth=1 https://github.com/libjpeg-turbo/buildscripts.git ~/src/buildscripts/libjpeg-turbo \
 && ~/src/buildscripts/libjpeg-turbo/autotools.install \
 && git clone --depth=1 https://gitlab.com/debsigs/debsigs.git -b debsigs-0.1.15%7Eroam1 ~/src/debsigs \
 && pushd ~/src/debsigs \
 && perl Makefile.PL \
 && make install \
 && popd \
 && rm -rf ~/src \
 && mkdir -p /usr/src/redhat \
 && yum -y install \
    ghostscript.x86_64 \
    texinfo.x86_64 \
 && rpm -i http://www.nasm.us/pub/nasm/releasebuilds/2.10.09/linux/nasm-2.10.09-1.src.rpm \
 && rpmbuild -ba /usr/src/redhat/SPECS/nasm.spec \
 && rpm -i /usr/src/redhat/RPMS/x86_64/nasm-[0-9]*.x86_64.rpm \
 && rm -rf /usr/src/redhat \
 && yum -y remove audit-libs-python fontconfig libfontenc libgpg-error libselinux-python libsemanage libtiff libFS libICE texinfo ttmkfdir \
 && mkdir /usr/java \
 && ln -fs /etc/alternatives/java_sdk /usr/java/default \
 && curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-i586.tar.gz | tar -C /usr/java/ -xz \
 && ln -fs /usr/java/jdk1.8.0_101 /usr/java/default32 \
 && rm -rf /usr/java/default32/*src.zip \
           /usr/java/default32/lib/missioncontrol \
           /usr/java/default32/lib/visualvm \
           /usr/java/default32/lib/*javafx* \
           /usr/java/default32/jre/lib/plugin.jar \
           /usr/java/default32/jre/bin/javaws \
           /usr/java/default32/jre/lib/javaws.jar \
           /usr/java/default32/jre/lib/desktop/* \
           /usr/java/default32/jre/plugin/* \
           /usr/java/default32/jre/lib/deploy* \
           /usr/java/default32/jre/lib/*javafx* \
           /usr/java/default32/jre/lib/*jfx* \
           /usr/java/default32/jre/lib/ext/* \
           /usr/java/default32/jre/lib/jfr* \
           /usr/java/default32/jre/lib/oblique-fonts/* \
           /usr/java/default32/jre/lib/i386/libdecora_sse.so \
           /usr/java/default32/jre/lib/i386/libprism_*.so \
           /usr/java/default32/jre/lib/i386/libfxplugins.so \
           /usr/java/default32/jre/lib/i386/libglass.so \
           /usr/java/default32/jre/lib/i386/libgstreamer-lite.so \
           /usr/java/default32/jre/lib/i386/libjavafx*.so \
           /usr/java/default32/jre/lib/i386/libjfx*.so \
 && cd / \
 && yum clean all \
 && find /usr/lib/locale/ -mindepth 1 -maxdepth 1 -type d -not -path '*en_US*' -exec rm -rf {} \; \
 && find /usr/share/locale/ -mindepth 1 -maxdepth 1 -type d -not -path '*en_US*' -exec rm -rf {} \; \
 && localedef --list-archive | grep -v -i ^en | xargs localedef --delete-from-archive \
 && mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl \
 && /usr/sbin/build-locale-archive \
 && echo "" >/usr/lib/locale/locale-archive.tmpl \
 && find /usr/share/{man,doc,info} -type f -delete \
 && rm -rf /etc/ld.so.cache \ && rm -rf /var/cache/ldconfig/* \
 && rm -rf /tmp/*

# Set environment
ENV PATH /opt/autotools/bin:${PATH}

# Set default command
CMD ["/bin/bash"]
