#!/usr/bin/env sh

set -e

if [ "$RAILS_BOOTSTRAP" = "1" ]; then
  echo "Running Rails bootstrap"
  DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:setup
  exit 0
fi

if [ "$RAILS_DB_MIGRATE" = "1" ]; then
  bundle exec rake db:migrate
fi

bundle exec rails assets:precompile
bundle exec rails server --binding 0.0.0.0 --port "${PORT:-3000}"
