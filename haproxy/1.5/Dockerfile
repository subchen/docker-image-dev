FROM subchen/centos:7
MAINTAINER Guoqiang Chen <subchen@gmail.com>

RUN yum makecache \
 && yum install -y haproxy \
 && rm -rf /etc/haproxy/haproxy.cfg \
 && yum clean all \
 && rm -rf /var/cache/yum/*

COPY haproxy.cfg.in /etc/haproxy/haproxy.cfg.in
COPY haproxy-run.sh /etc/haproxy/haproxy-run.sh

EXPOSE 80

CMD ["/etc/haproxy/haproxy-run.sh"]

