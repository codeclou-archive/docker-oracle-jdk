FROM codeclou/docker-alpine-glibc:2.25-rc0

ENV JAVA_VMAJOR 8
ENV JAVA_VMINOR 131
ENV JAVA_SHA512 92c90f19f0184dfd78ac2b98d8ba0cbddcac3b9fb318ca9eeb6f8c1ce62b5b286cae836edb04689ec62fc9ad6ebbfc0c48d0b107b716c24afe44a3ba41fb66f4
ENV JAVA_DOHASH d54c1d3a095b4ff2b6607d096fa80163

#
# BASE PACKAGES + DOWNLOAD ORACLE JAVA
#
RUN echo "=== INSTALLING ORACLE JDK ====================" && \
    echo "${JAVA_SHA512}  /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz" > /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz.sha512 && \
    curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz \
         http://download.oracle.com/otn-pub/java/jdk/${JAVA_VMAJOR}u${JAVA_VMINOR}-b11/${JAVA_DOHASH}/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz && \
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

