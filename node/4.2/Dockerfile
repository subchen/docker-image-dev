FROM subchen/centos:7
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV NODE_VERSION 4.3.0

RUN curl -fSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz -o node.tar.gz \
 && echo "98b60c86d541f44c5d07111f9ffc9a81848f976cfbe84f71cb9c7d6bfd34e1a4 node.tar.gz" | sha256sum -c \
 && tar -xzf node.tar.gz -C /usr/local --strip-components=1 \
 && rm -rf node.tar.gz

