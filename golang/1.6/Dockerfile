FROM centos:7.2.1511
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV GOLANG_VERSION 1.6.2
ENV GOLANG_HOME /usr/share/go

RUN set -e \
 && curl -fSL https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz -o golang.tar.gz \
 && echo "e40c36ae71756198478624ed1bb4ce17597b3c19d243f3f0899bb5740d56212a golang.tar.gz" | sha256sum -c - \
 && mkdir -p $GOLANG_HOME \
 && tar -zxf golang.tar.gz -C $GOLANG_HOME --strip-components=1 \
 && rm -rf golang.tar.gz

ENV GOROOT $GOLANG_HOME
ENV GOPATH /go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

RUN mkdir -p $GOPATH/bin $GOPATH/src

RUN yum makecache \
 && yum install -y git \
 && yum clean all \
 && rm -rf /var/cache/yum/*

WORKDIR $GOPATH
