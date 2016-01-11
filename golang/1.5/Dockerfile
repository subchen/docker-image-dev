FROM subchen/centos:7.2
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV GOLANG_VERSION 1.5.2
ENV GOLANG_HOME /usr/share/go

RUN set -e \
 && curl -fSL https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz -o golang.tar.gz \
 && echo "cae87ed095e8d94a81871281d35da7829bd1234e golang.tar.gz" | sha1sum -c - \
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
