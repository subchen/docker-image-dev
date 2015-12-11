FROM subchen/centos:7
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV NODE_VERSION 5.3.0

RUN curl -fSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz -o node.tar.gz \
 && echo "75b029b30d4a4147d67cf75bf6e034291fb5919c6935ec23f8365cee2d463f12 node.tar.gz" | sha256sum -c \
 && tar -xzf node.tar.gz -C /usr/local --strip-components=1 \
 && rm -rf node.tar.gz

