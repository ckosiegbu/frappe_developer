#!/bin/bash

if [[ -z "$MARIADB_HOST" ]]; then
  echo "MARIADB_HOST is not set"
  exit 1
fi

if [[ -z "$REDIS_CACHE" ]]; then
  echo "REDIS_CACHE is not set"
  exit 1
fi

if [[ -z "$REDIS_QUEUE" ]]; then
  echo "REDIS_QUEUE is not set"
  exit 1
fi

if [[ -z "$REDIS_SOCKETIO" ]]; then
  echo "REDIS_SOCKETIO is not set"
  exit 1
fi

source $HOME/.nvm/nvm.sh

if [ "$1" = 'start' ]; then
  bench config set-common-config --config db_host $MARIADB_HOST
  bench config set-common-config --config redis_cache $REDIS_CACHE
  bench config set-common-config --config redis_queue $REDIS_QUEUE
  bench config set-common-config --config redis_socketio $REDIS_SOCKETIO
  bench start
else
  "$@"
fi
