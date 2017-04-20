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
