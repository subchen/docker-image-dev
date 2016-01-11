FROM subchen/golang:1.5
MAINTAINER Guoqiang Chen <subchen@gmail.com>

RUN set -e \
 && go get github.com/skynetservices/skydns \
 && cd $GOPATH/src/github.com/skynetservices/skydns \
 && go build -v \
 && mv $GOPATH/bin/skydns /usr/bin \
 && rm -rf $GOPATH/*

EXPOSE 53 53/udp
CMD ["/usr/bin/skydns", "-addr=0.0.0.0:53", "-machines=http://etcd:2379"]
