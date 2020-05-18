#!/usr/bin/env sh

set -e

rm -f /app/tmp/pids/server.pid

exec "$@"
