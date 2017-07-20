FROM codeclou/docker-alpine-glibc:2.25-rc0

ENV JAVA_VMAJOR 8
ENV JAVA_VMINOR 141
ENV JAVA_SHA512 1ffaf30d2d8af71e1fe694d13a7cc4b135ce9ed5d3d2f1a39045d1bd6dbfa22d2f8656371b52312bb4f65e48e01f223d463022ef860da5b4a6453a5c165ab074
ENV JAVA_DOHASH 336fa29ff2bb4ef291e347e091f7f4a7

#
# BASE PACKAGES + DOWNLOAD ORACLE JAVA
#
RUN echo "=== INSTALLING ORACLE JDK ====================" && \
    echo "${JAVA_SHA512}  /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz" > /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz.sha512 && \
    curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz \
         http://download.oracle.com/otn-pub/java/jdk/${JAVA_VMAJOR}u${JAVA_VMINOR}-b15/${JAVA_DOHASH}/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz && \
    sha512sum -c /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz.sha512

#
# INSTALL AND CONFIGURE
#
RUN tar -C /opt -xf /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz && \
    mv /opt/jdk1.${JAVA_VMAJOR}.0_${JAVA_VMINOR} /opt/jdk && \
    rm -f /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz && \
    apk del curl gzip tar && \
    rm -rf /tmp/* /var/cache/apk/*

#
# MAKE FONTCONFIG WORK - SEE: https://github.com/codeclou/docker-oracle-jdk/blob/master/test/fontconfig/README.md
#
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/jdk/jre/lib/amd64/server/:/usr/lib/:/lib/
RUN apk add --no-cache libgcc \
                       ttf-dejavu \
                       fontconfig \
                       libgcc

#
# ENV
#
ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:/opt/jdk/bin/
