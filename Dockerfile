FROM zalando/ubuntu:15.04-1
MAINTAINER Zalando SE

RUN apt-get update && apt-get install -y openjdk-8-jdk

# Note: Zalando CA was automatically imported into Java trust store by Debian

ADD utils /java-utils
ENV PATH ${PATH}:/${JAVA_HOME}/bin:/java-utils

CMD ["java", "-version"]
