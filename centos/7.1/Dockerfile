FROM centos:7.1.1503
MAINTAINER Guoqiang Chen <subchen@gmail.com>

RUN yum makecache \
 && yum install -y net-tools tree wget zip unzip \
 && yum clean all \
 && rm -rf /var/cache/yum/*

