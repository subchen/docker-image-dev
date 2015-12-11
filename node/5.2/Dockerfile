FROM subchen/centos:7
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV NODE_VERSION 5.2.0

RUN curl -fSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz -o node.tar.gz \
 && echo "7f31f5db97e1def61454d268d5206a6826385d157f444c21a36230a6c18f40d2 node.tar.gz" | sha256sum -c \
 && tar -xzf node.tar.gz -C /usr/local --strip-components=1 \
 && rm -rf node.tar.gz

