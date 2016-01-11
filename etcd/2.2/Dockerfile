FROM subchen/centos:7.2
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV COREOS_ETCD_VERSION 2.2.3

RUN set -e \
 && curl -fSL https://github.com/coreos/etcd/releases/download/v${COREOS_ETCD_VERSION}/etcd-v${COREOS_ETCD_VERSION}-linux-amd64.tar.gz -o etcd.tar.gz \
 && mkdir -p /tmp/etcd \
 && tar -zxf etcd.tar.gz -C /tmp/etcd --strip-components=1 \
 && mv /tmp/etcd/etcd* /usr/bin \
 && rm -rf etcd.tar.gz /tmp/etcd \
 && mkdir -p /var/lib/etcd

EXPOSE 2379 2380
CMD ["/usr/bin/etcd", "-name=default", "-data-dir=/var/lib/etcd/default.etcd", "-listen-client-urls=http://0.0.0.0:2379", "-listen-peer-urls=http://0.0.0.0:2380", "-advertise-client-urls=http://127.0.0.1:2379"]
