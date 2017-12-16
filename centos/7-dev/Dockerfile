FROM centos:7

RUN yum makecache \
 && yum install -y git \
 && yum install -y make gcc gcc-c++ \
 && yum install -y rpm-build \
 && yum clean all \
 && rm -rf /var/cache/yum/*

################################################################
ENV GOVERSION 1.9.2
ENV GOROOT /usr/share/go
ENV GOPATH /go

ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

RUN set -e \
 && curl -fSL https://redirector.gvt1.com/edgedl/go/go${GOVERSION}.linux-amd64.tar.gz -o golang.tar.gz \
 && mkdir -p $GOROOT \
 && tar -zxf golang.tar.gz -C $GOROOT --strip-components=1 \
 && rm -rf golang.tar.gz \
 && mkdir -p $GOPATH/bin \
 && mkdir -p $GOPATH/src

RUN go get github.com/Masterminds/glide/... \
 && go get github.com/sgotti/glide-vc/... \
 && rm -rf $GOPATH/src/* \
 && rm -rf $GOPATH/pkg

################################################################
ENV NODE_VERSION 8.9.3

RUN curl -fSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz -o node.tar.gz \
 && tar -xzf node.tar.gz -C /usr/local --strip-components=1 \
 && rm -rf node.tar.gz

RUN npm install -g yarn
RUN yarn global add mocha istanbul nyc spec-xunit-file js-beautify eslint

################################################################
RUN yum install -y ruby ruby-devel libffi-devel
RUN gem install fpm
RUN gem install travis
