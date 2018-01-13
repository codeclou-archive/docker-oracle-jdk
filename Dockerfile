FROM codeclou/docker-alpine-glibc:2.26-rc0

ENV JAVA_VMAJOR 8
ENV JAVA_VMINOR 152
ENV JAVA_SHA512 b0851d46bf0385b7595f8d60da0f06ccdcd59aac75efa9b48635ba77a3e4eb557cbda5585fa5886787a0e549d9e5cfa4a992741349cfc224b36f180907838321
ENV JAVA_DOHASH aa0333dd3019491ca4f6ddbe78cdb6d0

#
# BASE PACKAGES + DOWNLOAD ORACLE JAVA
#
RUN echo "=== INSTALLING ORACLE JDK ====================" && \
    echo "${JAVA_SHA512}  /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz" > /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz.sha512 && \
    curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz \
         http://download.oracle.com/otn-pub/java/jdk/${JAVA_VMAJOR}u${JAVA_VMINOR}-b16/${JAVA_DOHASH}/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz && \
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
