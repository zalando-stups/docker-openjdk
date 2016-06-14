FROM registry.opensource.zalan.do/stups/alpine:UPSTREAM
MAINTAINER Zalando SE

RUN apk update && apk add openjdk8

# Note: Zalando CA should have been automatically imported into Java trust store by Alpine

ADD utils /java-utils
ENV PATH ${PATH}:/${JAVA_HOME}/bin:/java-utils

CMD ["java", "-version"]

