FROM centos:7

RUN yum makecache \
 && yum install -y git \
 && yum install -y make gcc gcc-c++ \
 && yum install -y rpm-build \
 && yum install -y openssh-clients which \
 && yum clean all \
 && rm -rf /var/cache/yum/*

################################################################
ENV GOVERSION 1.9.2
ENV GOROOT /usr/share/go
ENV GOPATH /go

ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

RUN curl -fSL https://redirector.gvt1.com/edgedl/go/go${GOVERSION}.linux-amd64.tar.gz -o golang.tar.gz \
 && mkdir -p $GOROOT \
 && tar -zxf golang.tar.gz -C $GOROOT --strip-components=1 \
 && rm -f golang.tar.gz \
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
 && rm -f node.tar.gz

RUN npm install -g yarn \
 && rm -rf $HOME/.npm

RUN yarn global add mocha istanbul nyc spec-xunit-file js-beautify eslint \
 && rm -rf /usr/local/share/.cache/yarn

################################################################
RUN yum install -y python python-devel \
 && yum clean all \
 && rm -rf /var/cache/yum/*

RUN curl -fSL https://bootstrap.pypa.io/get-pip.py | python

################################################################
RUN yum install -y ruby ruby-devel libffi-devel \
 && yum clean all \
 && rm -rf /var/cache/yum/*

RUN gem install fpm travis \
 && rm -rf $HOME/.gem

