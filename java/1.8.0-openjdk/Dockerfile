FROM subchen/centos:7
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV JAVA_VERSION 1.8.0
ENV JAVA_HOME /usr/lib/jvm/java-$JAVA_VERSION-openjdk

RUN yum makecache \
 && yum install -y java-$JAVA_VERSION-openjdk-devel \
 && yum clean all \
 && rm -rf /var/cache/yum/*

