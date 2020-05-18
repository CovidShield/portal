#!/usr/bin/env sh

mysql_healthy() {
  (docker ps | grep portal_mysql_1 | grep healthy) >/dev/null 2>&1
}

echo "Starting mysql..."
docker-compose up -d mysql

printf "Waiting for mysql to become healthy "
until mysql_healthy
do
  sleep 2
  printf "."
done
printf " \x1b[32mdone\x1b[0m\n"

echo "Bootstrapping the database..."
docker-compose run -e RAILS_BOOTSTRAP=1 portal /start-server.sh
