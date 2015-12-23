#!/bin/bash

HAPROXY_CFG=/etc/haproxy/haproxy.cfg

#HAPROXY_SERVERS="10.0.0.1:80 10.0.0.2:80"

if [ ! -f $HAPROXY_CFG ]; then
  serverlist="\n"
  index=0
  for server in $HAPROXY_SERVERS; do
    index=$(expr $index + 1)
    serverlist="$serverlist  server web$index $server cookie web$index check\n"
  done
  sed "s/{{serverlist}}/$serverlist/g" $HAPROXY_CFG.in > $HAPROXY_CFG
fi

exec /usr/sbin/haproxy -f $HAPROXY_CFG

