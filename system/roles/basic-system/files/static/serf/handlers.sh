#!/bin/bash
# Serf router handler.

# Handler executables must be placed in HANDLER_DIR directory and named by event
# type for this recipe to work (e.g. member-join). User events get prefixed with
# "user-", and queries with "query-" (user-deploy, query-uptime, etc.).

# Example content of /etc/serf/handlers
#  ├── member-failed
#  ├── member-join
#  ├── member-leave
#  ├── member-update
#  ├── user-deploy
#  └── query-uptime


HANDLER_DIR="/etc/serf/handlers"

if [ "$SERF_EVENT" = "user" ]; then
    EVENT="user-$SERF_USER_EVENT"
elif [ "$SERF_EVENT" = "query" ]; then
    EVENT="query-$SERF_QUERY_NAME"
else
    EVENT=$SERF_EVENT
fi

HANDLER="$HANDLER_DIR/$EVENT"
[ -f "$HANDLER" -a -x "$HANDLER" ] && exec "$HANDLER" || :

# vim: set ts=8 sts=4 sw=4 et:
