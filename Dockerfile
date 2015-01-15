FROM zalando/ubuntu:14.04.1-1
MAINTAINER Henning Jacobs <henning.jacobs@zalando.de>

RUN apt-get update

# Workaround to use latest OpenJDK package which is only available for utopic
RUN curl -o /tmp/openjdk-8-#1.deb http://de.archive.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-{jre,jre-headless,jdk}_8u40~b09-1_amd64.deb
# http://stackoverflow.com/questions/8477036/how-to-make-debian-package-install-dependencies
RUN dpkg -i /tmp/openjdk-8-*.deb || apt-get -f --force-yes --yes install
RUN dpkg -i /tmp/openjdk-8-*.deb
RUN rm /tmp/openjdk-8-*.deb

CMD ["java", "-version"]
