#!/bin/bash
set -e

if [ "$1" = "mongod" ]; then

  #if [ -f /sys/kernel/mm/transparent_hugepage/enabled ]; then
  #  echo never > /sys/kernel/mm/transparent_hugepage/enabled
  #fi
  #if [ -f /sys/kernel/mm/transparent_hugepage/defrag ]; then
  #  echo never > /sys/kernel/mm/transparent_hugepage/defrag
  #fi

  #chown -R mongodb:mongodb /data/db

  exec gosu mongodb "$@"
fi

exec "$@"

