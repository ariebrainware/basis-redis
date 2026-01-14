#!/bin/sh
set -e

if [ -z "${REDIS_PASSWORD}" ]; then
  echo "No REDIS_PASSWORD set — generating a random password."
  # Generate a 32-character alphanumeric password from /dev/urandom
  REDIS_PASSWORD=$(head -c 256 /dev/urandom | tr -dc 'A-Za-z0-9' | cut -c1-32)
  export REDIS_PASSWORD
  echo "Generated REDIS_PASSWORD: ${REDIS_PASSWORD}"
fi

# Render the config file from template
envsubst < /usr/local/etc/redis/redis.conf.template > /usr/local/etc/redis/redis.conf

# Exec redis-server with the rendered config
exec "$@"
