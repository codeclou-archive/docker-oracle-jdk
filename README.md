# docker-oracle-jdk

[![](https://codeclou.github.io/doc/badges/generated/docker-image-size-250.svg?v2)](https://hub.docker.com/r/codeclou/docker-oracle-jdk/tags/) [![](https://codeclou.github.io/doc/badges/generated/docker-from-alpine-3.5.svg)](https://alpinelinux.org/) [![](https://codeclou.github.io/doc/badges/generated/docker-run-as-non-root.svg)](https://docs.docker.com/engine/reference/builder/#/user)

Base Docker-Image that includes [Oracle Java 8 JDK](https://www.oracle.com/java/) and [glibc](https://github.com/sgerrand/alpine-pkg-glibc) based on [Alpine Linux](https://alpinelinux.org/).

-----

&nbsp;

### Usage

Extend in your Dockerfile like so:

```
FROM codeclou/docker-oracle-jdk:8u121
...
```


-----
&nbsp;

### License, Liability & Support

 * [![](https://codeclou.github.io/doc/docker-warranty-notice.svg?v1)](https://github.com/codeclou/docker-oracle-jdk/blob/master/LICENSE)
 * Dockerfile and Image is provided under [MIT License](https://github.com/codeclou/docker-oracle-jdk/blob/master/LICENSE)
 * [Oracle Java JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) might be licensed differently. Please check for yourself.
   * Note: By using this docker image you automatically accept the License Terms of Oracle Java 8 JDK.
