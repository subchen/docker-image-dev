#!/bin/bash

KEEPALIVED_CONF=/etc/keepalived/keepalived.conf

if [ ! -f $KEEPALIVED_CONF ]; then
  state=${KEEPALIVED_STATE:-MASTER}
  priority=${KEEPALIVED_PRIORITY:-200}
  src=$(ip addr show eth0 | sed -n -r 's/.*inet ([0-9\.]+).*/\1/p')
  peer=${KEEPALIVED_PEER}
  vip=${KEEPALIVED_VIP:-172.17.0.200}

  # master is 200, backup is 100
  if [[ "$KEEPALIVED_STATE" = "BACKUP" && "$KEEPALIVED_PRIORITY" = "" ]]; then
    priority=100
  fi

  sed -e "s/{{state}}/$state/g" \
      -e "s/{{priority}}/$priority/g" \
      -e "s/{{src}}/$src/g" \
      -e "s/{{peer}}/$peer/g" \
      -e "s/{{vip}}/$vip/g" \
      $KEEPALIVED_CONF.in > $KEEPALIVED_CONF
fi

exec /usr/sbin/keepalived -f $KEEPALIVED_CONF --dont-fork --log-console

