FROM subchen/centos:7
MAINTAINER Guoqiang Chen <subchen@gmail.com>

# consul
ENV CONSUL_VERSION 0.6.0

RUN set -e \
 && curl -fSL https://releases.hashicorp.com/consul/$CONSUL_VERSION/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip \
 && echo "b82b8086b61fc9cddf398a45400fa781 consul.zip" | md5sum -c \
 && unzip consul.zip -d /usr/bin \
 && rm -rf consul.zip

# consul-web-ui
ENV CONSUL_WEB_UI_VERSION 0.6.0

RUN set -e \
 && curl -fSL https://releases.hashicorp.com/consul/$CONSUL_WEB_UI_VERSION/consul_${CONSUL_WEB_UI_VERSION}_web_ui.zip -o consul-web-ui.zip \
 && echo "203dbf20caa91bbbc6554629b8550aeb consul-web-ui.zip" | md5sum -c \
 && mkdir -p /ui/ \
 && unzip consul-web-ui.zip -d /ui/ \
 && rm -rf consul-web-ui.zip

# consul-replicate
ENV CONSUL_REPLICATE_VERSION 0.2.0

RUN set -e \
 && curl -fSL https://releases.hashicorp.com/consul-replicate/$CONSUL_REPLICATE_VERSION/consul-replicate_${CONSUL_REPLICATE_VERSION}_linux_amd64.zip -o consul-replicate.zip \
 && echo "a54cf608403a5c194217b00e5afa1d38 consul-replicate.zip" | md5sum -c \
 && unzip consul-replicate.zip -d /usr/bin \
 && rm -rf consul-replicate.zip

# consul-template
ENV CONSUL_TEMPLATE_VERSION 0.12.0

RUN set -e \
 && curl -fSL https://releases.hashicorp.com/consul-template/$CONSUL_TEMPLATE_VERSION/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o consul-template.zip \
 && echo "d59a8d7552790b9a7ba841a6103cc4d8 consul-template.zip" | md5sum -c \
 && unzip consul-template.zip -d /usr/bin \
 && rm -rf consul-template.zip


# dirs 
RUN mkdir -p /etc/consul.d /data

VOLUME ["/data"]


EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600/udp

CMD ["/usr/bin/consul", "agent", "-server", "-bootstrap", "-client=0.0.0.0", "-data-dir=/data", "-ui-dir=/ui", "-config-dir=/etc/consul.d"]

