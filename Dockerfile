FROM redis:7-alpine

LABEL maintainer="Arie Brainware"

WORKDIR /usr/local/etc/redis

# Copy config template and entrypoint
COPY redis.conf.template /usr/local/etc/redis/redis.conf.template
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
