#Author https://github.com/sjatgutzmann

# base of this image is centos in version 7
FROM centos:centos7
MAINTAINER Sven Jörns <sj.at.gutzmann@gmail.com>

# running commands to build your service
# every RUN create a new image step. So, it's a good idea to merge all console commands with && together
RUN yum -y update; yum clean all \
 && yum -y install sudo epel-release sed wget which\
# lanugae support
# reinstall glib to get all lanuages
 && yum -y reinstall glibc-common

# Install java
# https://www.digitalocean.com/community/tutorials/how-to-install-java-on-centos-and-fedora
# enviroment in this Dockfile and in the running container
ENV JAVA_MAJOR_VERSION=8
ENV JAVA_MINOR_VERSION=111
ENV JAVA_BUILD_VERSION=14
ENV JAVA_HOME=/usr/java/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_MINOR_VERSION}/

# to download java from oracle, you need ti acceot the licence
# doing this with a cookie
RUN wget --no-cookies --no-check-certificate --header \
"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}-b${JAVA_BUILD_VERSION}/jdk-${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}-linux-x64.rpm" \
# install downloaded rpm file
 && yum -y localinstall jdk-${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}-linux-x64.rpm \
# remove downloaded rpm file to save spave in this image
 && rm -f jdk-${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}-linux-x64.rpm \
# just print out the version 
 && java -version

# this image will not provied a service, so normaly nothing to start
# starting a bash to test something 
# this entrypoint is in exec form
# https://til.codes/docker-run-vs-cmd-vs-entrypoint/
ENTRYPOINT /bin/bash
 
