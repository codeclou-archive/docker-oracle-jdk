FROM alpine:3.5

ENV JAVA_VMAJOR 8
ENV JAVA_VMINOR 121
ENV JAVA_SHA512 81b312545da41aca5df3871bdd05ea88ffc24776d5876df1e81d88bdb90e09ec09e898d30cc4d75fb6894827537961211a414ef1e03054f007a69b13ed761f5d

ENV GLIBC_VERSN 2.23-r3
ENV GLIBC_SH512 f9aa7e0bdc71fb560f99d6f447c73b5796a0ccf084e625feddbdc235e32ca722504f2e72be89fed954f6bfda3e10ed107952ae1bd5b6e1b2c6993479ff286a20

#
# BASE PACKAGES + DOWNLOAD GLIBC & ORACLE JAVA
#
COPY ./vendor-keys/sgerrand.rsa.pub /etc/apk/keys/
RUN apk add --no-cache \
            bash \
            ca-certificates \
            curl \
            gzip \
            tar && \
    echo "=== INSTALLING GLIBC =========================" && \
    echo "${GLIBC_SH512}  /opt/glibc-${GLIBC_VERSN}.apk" > /opt/glibc-${GLIBC_VERSN}.apk.sha512 && \
    curl -jkSL -o /opt/glibc-${GLIBC_VERSN}.apk \
        https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSN}/glibc-${GLIBC_VERSN}.apk && \
    sha512sum -c /opt/glibc-${GLIBC_VERSN}.apk.sha512 && \
    apk add /opt/glibc-${GLIBC_VERSN}.apk && \
    echo "=== INSTALLING ORACLE JDK ====================" && \
    echo "${JAVA_SHA512}  /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz" > /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz.sha512 && \
    curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz \
         http://download.oracle.com/otn-pub/java/jdk/${JAVA_VMAJOR}u${JAVA_VMINOR}-b14/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz && \
    sha512sum -c /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz.sha512 && \

#
# INSTALL AND CONFIGURE
#
RUN tar -C /opt -xf /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz && \
    mv /opt/jdk1.${JAVA_VMAJOR}.0_${JAVA_VMINOR} /opt/jdk && \
    rm -f /opt/jdk-${JAVA_VMAJOR}u${JAVA_VMINOR}-linux-x64.tar.gz && \
    rm -f /opt/glibc-${GLIBC_VERSN}.apk && \
    apk del curl gzip tar && \
    rm -rf /opt/jdk/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/bin/jjs \
           /opt/jdk/jre/bin/orbd \
           /opt/jdk/jre/bin/pack200 \
           /opt/jdk/jre/bin/policytool \
           /opt/jdk/jre/bin/rmid \
           /opt/jdk/jre/bin/rmiregistry \
           /opt/jdk/jre/bin/servertool \
           /opt/jdk/jre/bin/tnameserv \
           /opt/jdk/jre/bin/unpack200 \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/lib/ext/nashorn.jar \
           /opt/jdk/jre/lib/oblique-fonts \
           /opt/jdk/jre/lib/plugin.jar \
           /tmp/* /var/cache/apk/*

#
# RUN
#
ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:/opt/jdk/bin/
CMD ["java -version"]
