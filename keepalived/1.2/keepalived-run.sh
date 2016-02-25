#!/bin/bash

KEEPALIVED_CONF=/etc/keepalived/keepalived.conf

if [ ! -f $KEEPALIVED_CONF ]; then
  state=${KEEPALIVED_STATE:-MASTER}
  peer=${KEEPALIVED_PEER}
  vip=${KEEPALIVED_VIP:-172.17.0.200}

  # master is 150, backup is 100
  if [[ "$KEEPALIVED_STATE" = "MASTER" ]]; then
    state=BACKUP
    priority=150
    nopreempt=nopreempt
  else
    state=BACKUP
    priority=100
    nopreempt=preempt
  fi

  sed -e "s/{{state}}/$state/g" \
      -e "s/{{priority}}/$priority/g" \
      -e "s/{{nopreempt}}/$nopreempt/g" \
      -e "s/{{peer}}/$peer/g" \
      -e "s/{{vip}}/$vip/g" \
      $KEEPALIVED_CONF.in > $KEEPALIVED_CONF
fi

exec /usr/sbin/keepalived -f $KEEPALIVED_CONF --vrrp --dont-fork --log-console

