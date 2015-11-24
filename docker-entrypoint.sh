#!/bin/bash
set -e

function setConfiguration() {
  KEY=$1
  VALUE=$2
  sed -i "s/url.*$KEY/url: $VALUE/g" /usr/share/grafana/config.js
}

if [ -n "${GRAPHITE_URL+1}" ]; then
  setConfiguration "GRAPHITE_URL" "$GRAPHITE_URL"
fi
if [ -n "${ES_URL+1}" ]; then
  setConfiguration "ES_URL" "$ES_URL"
fi

if [[ "$1" == "grafana" ]]; then
  exec /usr/sbin/apache2ctl -D FOREGROUND
fi

exec "$@"
