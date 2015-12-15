FROM subchen/java:8
MAINTAINER Guoqiang Chen <subchen@gmail.com>

ENV TOMCAT_VERSION 9.0.0.M1
ENV TOMCAT_HOME /usr/share/tomcat
ENV CATALINA_HOME $TOMCAT_HOME

RUN curl -fSL https://www.apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION:0:1}/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz -o tomcat.tar.gz \
 && echo "e794b1c8a4d1427db42b3cc033e0ba2e tomcat.tar.gz" | md5sum -c \
 && mkdir -p $TOMCAT_HOME \
 && tar xzf tomcat.tar.gz --strip-components=1 -C $TOMCAT_HOME \
 && rm -rf tomcat.tar.gz \
 && rm -rf $TOMCAT_HOME/bin/*.bat

EXPOSE 8080

CMD $TOMCAT_HOME/bin/catalina.sh run

