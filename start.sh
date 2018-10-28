#!/bin/bash
#ADMIN_USER="$1"
#ADMIN_PASS="$2"
sh docker-entrypoint.sh rabbitmq-server & sleep 10 && 
rabbitmq-plugins enable rabbitmq_management rabbitmq_shovel &&
rabbitmqctl add_user "$ADMIN_USER" "$ADMIN_PASS"
rabbitmqctl set_user_tags "$ADMIN_USER" administrator
rabbitmqctl add_vhost /
rabbitmqctl set_permissions -p / "$ADMIN_USER" ".*" ".*" ".*"
tail -f /var/log/rabbitmq/*.log

