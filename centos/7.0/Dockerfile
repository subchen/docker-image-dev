FROM centos:7.0.1406
MAINTAINER Guoqiang Chen <subchen@gmail.com>

RUN yum makecache \
 && yum install -y net-tools tree wget zip unzip \
 && yum clean all \
 && rm -rf /var/cache/yum/*

