FROM alpine:3.3
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV NODE_VERSION 6.2.0

RUN apk add --no-cache libgcc libstdc++

RUN apk add --no-cache --virtual .build-deps curl make gcc g++ python linux-headers paxctl \
 && curl -fSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz -o node.tar.gz \
 && mkdir -p /tmp/src \
 && tar -xzf node.tar.gz -C /tmp/src \
 && rm -rf node.tar.gz \
 && cd /tmp/src/node-* \
 && export GYP_DEFINES="linux_use_gold_flags=0" \
 && ./configure --prefix=/usr --without-snapshot \
 && make \
 && make install \
 && paxctl -cm /usr/bin/node \
 && apk del .build-deps \
 && npm cache clean \
 && rm -rf /tmp/* /var/cache/apk/* \
    /root/.npm /root/.node-gyp /usr/share/man \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

