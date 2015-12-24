FROM subchen/centos:7
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV REDIS_VERSION 3.0.6

RUN set -e \
 && yum makecache \
 && yum install -y gcc make \
 && curl -fSL http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz -o redis.tar.gz \
 && echo "9a44ea6bff987d2113caea7761730376 redis.tar.gz" | md5sum -c \
 && mkdir -p /tmp/redis \
 && tar -xzf redis.tar.gz -C /tmp/redis --strip-components=1 \
 && rm -rf redis.tar.gz \
 && make -C /tmp/redis PREFIX=/usr/ install \
 && cp /tmp/redis/*.conf /etc/ \
 && rm -r /tmp/redis \
 && yum erase -y gcc make \
 && yum clean all \
 && rm -rf /var/cache/yum/*

RUN set -e \
 && sed -e "s/^\(bind .*\)$/# \1/" \
        -e "s/^\(daemonize .*\)$/# \1/" \
        -e "s/^\(dir .*\)$/dir \/data/" \
        -e "s/^\(logfile .*\)$/# \1/" \
        -i /etc/redis.conf

VOLUME ["/data"]

EXPOSE 6379 26379

# CMD ["/usr/bin/redis-sentinel", "/etc/sentinel.conf"]
CMD ["/usr/bin/redis-server", "/etc/redis.conf"]

