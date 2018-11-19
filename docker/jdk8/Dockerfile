FROM registry.opensource.zalan.do/stups/ubuntu:latest
MAINTAINER Zalando SE

# mkdir required because of https://github.com/resin-io-library/base-images/issues/273
RUN mkdir /usr/share/man/man1 && apt-get update && apt-get install --no-install-recommends -y openjdk-8-jdk

# Note: Zalando CA should have been automatically imported into Java trust store by Debian

# currently, Ubuntu 15.10 does not properly generate truststore for the JDK
# the ca-certificates jks-keystore update.d hook does not know about java-8 :-(
# Workaround: import all certs manually
RUN for i in /etc/ssl/certs/*.pem; do yes | keytool -importcert -alias $i -keystore /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts -storepass changeit -file $i; done
RUN keytool -list -keystore /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts -storepass changeit | grep zalando

ADD utils /java-utils
ENV PATH ${PATH}:/${JAVA_HOME}/bin:/java-utils

CMD ["java", "-version"]

RUN purge.sh
