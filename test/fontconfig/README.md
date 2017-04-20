# Oracle Java 8 under Alpine Linux

We need fontconfig support, since Atlassian JIRA/Confluence depend on that.

To test if font support is working inside our container we need to run the following test:

```bash
git clone https://github.com/codeclou/docker-oracle-jdk.git
cd docker-oracle-jdk/test/fontconfig

docker run -i -t --rm -v $(pwd):/work -w /work codeclou/docker-oracle-jdk:8u131 bash
```

Now inside the Docker container run:

```
javac Test.java
java -Dsun.java2d.debugfonts=true -cp . Test
```

Now there should be no errors.


# Debug

The `java:8` image gives the following output:

```
root@2c579135db94:/# ldd /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libfontmanager.so
	linux-vdso.so.1 (0x00007ffc4f7eb000)
	libfreetype.so.6 => /usr/lib/x86_64-linux-gnu/libfreetype.so.6 (0x00007f67527e3000)
	libawt.so => /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libawt.so (0x00007f6752512000)
	libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f6752206000)
	libjava.so => /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libjava.so (0x00007f6751fd6000)
	libjvm.so => not found
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f6751cd4000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f6751929000)
	libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f6751713000)
	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f67514f7000)
	libpng12.so.0 => /lib/x86_64-linux-gnu/libpng12.so.0 (0x00007f67512d0000)
	libjvm.so => not found
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f67510cb000)
	/lib64/ld-linux-x86-64.so.2 (0x000055e0302de000)
	libjvm.so => not found
	libverify.so => /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libverify.so (0x00007f6750eb8000)
	libjvm.so => not found
```

Our image gives

```
xception in thread "main" java.lang.UnsatisfiedLinkError: /opt/jdk/jre/lib/amd64/libfontmanager.so: libgcc_s.so.1: cannot open shared object file: No such file or directory
	at java.lang.ClassLoader$NativeLibrary.load(Native Method)
	at java.lang.ClassLoader.loadLibrary0(ClassLoader.java:1941)
	at java.lang.ClassLoader.loadLibrary(ClassLoader.java:1845)
	at java.lang.Runtime.loadLibrary0(Runtime.java:870)
	at java.lang.System.loadLibrary(System.java:1122)
	at sun.font.FontManagerNativeLibrary$1.run(FontManagerNativeLibrary.java:61)
	at java.security.AccessController.doPrivileged(Native Method)
	at sun.font.FontManagerNativeLibrary.<clinit>(FontManagerNativeLibrary.java:32)
	at sun.font.SunFontManager$1.run(SunFontManager.java:339)
	at java.security.AccessController.doPrivileged(Native Method)
	at sun.font.SunFontManager.<clinit>(SunFontManager.java:335)
	at java.lang.Class.forName0(Native Method)
	at java.lang.Class.forName(Class.java:348)
	at sun.font.FontManagerFactory$1.run(FontManagerFactory.java:82)
	at java.security.AccessController.doPrivileged(Native Method)
	at sun.font.FontManagerFactory.getInstance(FontManagerFactory.java:74)
	at java.awt.Font.<init>(Font.java:614)
	at java.awt.Font.createFont(Font.java:1056)
	at Test.main(Test.java:8)
bash-4.3# ldd /opt/jdk/jre/lib/amd64/libfontmanager.so
	ldd (0x55631e7a9000)
	libawt.so => /opt/jdk/jre/lib/amd64/libawt.so (0x7f18cbd8b000)
	libm.so.6 => ldd (0x55631e7a9000)
	libjava.so => /opt/jdk/jre/lib/amd64/libjava.so (0x7f18cbb5f000)
Error loading shared library libjvm.so: No such file or directory (needed by /opt/jdk/jre/lib/amd64/libfontmanager.so)
	libc.so.6 => ldd (0x55631e7a9000)
	ld-linux-x86-64.so.2 => /lib/ld-linux-x86-64.so.2 (0x7f18cb93a000)
	libgcc_s.so.1 => /usr/lib/libgcc_s.so.1 (0x7f18cb728000)
Error loading shared library libjvm.so: No such file or directory (needed by /opt/jdk/jre/lib/amd64/libawt.so)
	libdl.so.2 => ldd (0x55631e7a9000)
Error loading shared library libjvm.so: No such file or directory (needed by /opt/jdk/jre/lib/amd64/libjava.so)
	libverify.so => /opt/jdk/jre/lib/amd64/libverify.so (0x7f18cb51a000)
Error loading shared library libjvm.so: No such file or directory (needed by /opt/jdk/jre/lib/amd64/libverify.so)
```
