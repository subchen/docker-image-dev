FROM subchen/haproxy:1.5
MAINTAINER Guoqiang Chen <subchen@gmail.com>

RUN yum makecache \
 && yum install -y keepalived \
 && yum clean all \
 && rm -rf /var/cache/yum/*


# This image require the kernel module ip_vs loaded on the host (modprobe ip_vs) 
# And need to be run with : --cap-add=NET_ADMIN --net=host
#   docker run --cap-add=NET_ADMIN --net=host -d subchen/keepalived

COPY haproxy-check.sh /etc/keepalived/haproxy-check.sh
COPY keepalived-run.sh /etc/keepalived/keepalived-run.sh
COPY keepalived.conf.in /etc/keepalived/keepalived.conf.in

CMD ["/etc/keepalived/keepalived-run.sh"]

