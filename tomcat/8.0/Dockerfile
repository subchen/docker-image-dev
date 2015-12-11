FROM subchen/java:8
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV TOMCAT_VERSION 8.0.30
ENV TOMCAT_HOME /usr/share/tomcat
ENV CATALINA_HOME $TOMCAT_HOME

RUN curl -fSL https://www.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR:0:1}/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz -o tomcat.tar.gz \
 && echo "4fc750ab343f6bd8df92cdb02b7b39e3 tomcat.tar.gz" | md5sum -c \
 && mkdir -p $TOMCAT_HOME \
 && tar xzf tomcat.tar.gz --strip-components=1 -C $TOMCAT_HOME \
 && rm -rf tomcat.tar.gz \
 && rm -rf $TOMCAT_HOME/bin/*.bat

EXPOSE 8080

CMD $TOMCAT_HOME/bin/catalina.sh run

