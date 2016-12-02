#Author https://github.com/sjatgutzmann

FROM centos:centos7
MAINTAINER Sven Jörns <sj.at.gutzmann@gmail.com>

ENV JAVA_MAJOR_VERSION=8
ENV JAVA_MINOR_VERSION=111
ENV JAVA_BUILD_VERSION=14

RUN yum -y update; yum clean all \
 && yum -y install sudo epel-release sed wget \
# lanugae support
# reinstall glib to get all lanuages
 && yum -y reinstall glibc-common

# Install java
# https://www.digitalocean.com/community/tutorials/how-to-install-java-on-centos-and-fedora

RUN wget --no-cookies --no-check-certificate --header \
"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}-b${JAVA_BUILD_VERSION}/jdk-${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}-linux-x64.rpm" 
RUN yum -y localinstall jdk-${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}-linux-x64.rpm \
 && rm -f jdk-${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}-linux-x64.rpm

ENTRYPOINT /bin/bash
CMD java --version
 
