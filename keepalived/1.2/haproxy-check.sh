#!/bin/bash

pslist=`ps -C haproxy --no-header | wc -l`
if [ $pslist -eq 0 ]; then
    /etc/haproxy/haproxy-run.sh

    pslist=`ps -C haproxy --no-header | wc -l`
    if [ $pslist -eq 0 ]; then
        /etc/init.d/keepalived stop
    fi
fi

