FROM subchen/centos:7
MAINTAINER Guoqiang Chen <subchen@gmail.com>

# gosu
RUN set -e \
 && curl -fSL https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 -o /usr/bin/gosu \
 && echo "2dc2411c4324088b5fea9e32b361344c /usr/bin/gosu" | md5sum -c \
 && chmod +x /usr/bin/gosu


ENV MONGO_VERSION 3.2.0
ENV MONGO_HOME /usr/share/mongodb
ENV PATH $MONGO_HOME/bin:$PATH

# mongodb
RUN set -e \
 && curl -fSL https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-${MONGO_VERSION}.tgz -o mongodb.tar.gz \
 && echo "122f92bdfb3d1441f715195d8f60e01a mongodb.tar.gz" | md5sum -c \
 && mkdir -p $MONGO_HOME \
 && tar -zxf mongodb.tar.gz -C $MONGO_HOME --strip-components=1 \
 && rm -rf mongodb.tar.gz

# user group
RUN set -e \
 && groupadd -r mongodb \
 && useradd -r -g mongodb mongodb \
 && mkdir -p /data/db \
 && chown -R mongodb:mongodb /data/db

VOLUME /data/db

EXPOSE 27017

COPY docker-entrypoint.sh /sbin/docker-entrypoint.sh

ENTRYPOINT ["/sbin/docker-entrypoint.sh"]
CMD ["mongod", "--dbpath", "/data/db"]

