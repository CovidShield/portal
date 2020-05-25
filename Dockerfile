FROM ruby:2-alpine@sha256:2f64029e66742642f94805bece89304c8a644fb565dd3170e841bc11ebea181d
LABEL maintainer="security@covidshield.app"
LABEL app.covidshield.name="COVID Shield Portal"
LABEL app.covidshield.description="The Web Portal for covidshield.app"
LABEL app.covidshield.url="https://covidshield.app/"
LABEL app.covidshield.docker.cmd="docker run -v `pwd`:/app -p 3000:3000 -d covidshield/portal"

# add a user early so it does not get clobbered
ARG APP_NAME=${APP_NAME:-portal}
ARG APP_GID=${APP_GID:-2000}
ARG APP_UID=${APP_UID:-2000}
ARG APP_HOME=${APP_HOME:-/app}
RUN addgroup -g ${APP_GID} ${APP_NAME} && \
    adduser -D \
    -h ${APP_HOME} \
    -s /bin/sh \
    -u ${APP_UID} \
    -G ${APP_NAME} \
    ${APP_NAME}

# runtime dependencies: yarn, nodejs, and bundler
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
# hadolint ignore=DL3018
RUN apk add --no-cache build-base yarn nodejs mysql-dev tzdata


# set the working directory and install gems
WORKDIR ${APP_HOME}
USER ${APP_UID}:${APP_GID}
COPY --chown=${APP_UID}:${APP_GID} Gemfile Gemfile.lock ${APP_HOME}/
RUN gem install bundler:2.1.1
RUN bundle config set without 'test development' && \
    bundle install --jobs 4

# copy in the application code after
COPY --chown=${APP_UID}:${APP_GID} . ${APP_HOME}
RUN yarn install --check-files

EXPOSE 3000
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY start-server.sh /start-server.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/start-server.sh"]
