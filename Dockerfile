FROM zalando/ubuntu:15.10-2
MAINTAINER Zalando SE

RUN apt-get update && apt-get install -y openjdk-8-jdk

# Note: Zalando CA was automatically imported into Java trust store by Debian

# currently, ubuntu does not properly generate truststore for the jdk
# workaround:
RUN apt-get -y --reinstall install ca-certificates-java && update-ca-certificates -f

ADD utils /java-utils
ENV PATH ${PATH}:/${JAVA_HOME}/bin:/java-utils

CMD ["java", "-version"]
