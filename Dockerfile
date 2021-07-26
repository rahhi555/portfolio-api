FROM ruby:3.0.2-alpine
ARG WORKDIR

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata git mysql-dev mariadb-client" \
    DEV_PACKAGES="build-base curl-dev" \
    HOME=/api \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR ${HOME}

COPY . .

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install -j4 && \
    apk del build-dependencies && \
    rm -f ${HOME}/tmp/pids/server.pid \

EXPOSE 3000