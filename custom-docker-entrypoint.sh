#!/bin/sh

# NOTE:
# Without the initial sleep, you will probably hit this issue:
# https://github.com/docker-library/rabbitmq/issues/114
# https://github.com/docker-library/rabbitmq/issues/318
(sleep 10 && rabbitmqctl wait --timeout 60 "$RABBITMQ_PID_FILE" ; \
    rabbitmqctl add_user "$RABBITMQ_USER" "$RABBITMQ_PASSWORD" 2>/dev/null ; \
    rabbitmqctl set_user_tags "$RABBITMQ_USER" administrator ; \
    rabbitmqctl set_permissions -p / "$RABBITMQ_USER"  ".*" ".*" ".*" ; \
    echo "*** User '$RABBITMQ_USER' with password '$RABBITMQ_PASSWORD' completed. ***" ; \
    echo "*** Log in the WebUI at port 15672 (example: http:/localhost:15672) ***") &

exec /usr/local/bin/docker-entrypoint.sh "$@"
