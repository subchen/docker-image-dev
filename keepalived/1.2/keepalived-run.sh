#!/bin/bash

KEEPALIVED_CFG=/etc/keepalived/keepalived.cfg

if [ ! -f $KEEPALIVED_CFG ]; then
  state=${KEEPALIVED_STATE:-MASTER}
  priority=${KEEPALIVED_PRIORITY:-999}
  peer=${KEEPALIVED_PEER}
  vip=${KEEPALIVED_VIP:-172.17.0.200}

  # master is 999, backup is 100
  if [[ "$state" == "BACKUP" && "$priority" == ""  ]]; then
    priority=100
  fi

  sed -e "s/{{state}}/$state/g" \
      -e "s/{{priority}}/$priority/g" \
      -e "s/{{peer}}/$peer/g" \
      -e "s/{{vip}}/$vip/g" \
      $KEEPALIVED_CFG.in > $KEEPALIVED_CFG
fi

exec /usr/sbin/keepalived -f $KEEPALIVED_CFG --dont-fork --log-console

