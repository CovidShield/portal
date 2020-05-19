#!/usr/bin/env sh

set -e

bundle exec rails assets:precompile
bundle exec rails server --binding 0.0.0.0 --port "${PORT:-3000}"
