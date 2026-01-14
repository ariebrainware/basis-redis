#!/bin/sh
set -e

if [ -z "${REDIS_PASSWORD}" ]; then
  echo "ERROR: REDIS_PASSWORD is not set. Set a strong password in your environment or .env file."
  exit 1
fi

# Render the config file from template
envsubst < /usr/local/etc/redis/redis.conf.template > /usr/local/etc/redis/redis.conf

# Exec redis-server with the rendered config
exec "$@"
