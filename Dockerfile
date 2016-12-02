#Author https://github.com/sjatgutzmann

FROM centos:centos7
MAINTAINER Sven Jörns <sj.at.gutzmann@gmail.com>

RUN yum -y update; yum clean all \
 && yum -y install sudo epel-release sed \
# lanugae support
# reinstall glib to get all lanuages
 && yum -y reinstall glibc-common
