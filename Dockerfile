FROM elixir:alpine
RUN      apk update && \
         apk upgrade && \
         apk --no-cache add \
         git openssh openssl-dev build-base bash vim busybox-extras sudo inotify-tools

RUN addgroup -S -g 1000 io && adduser -S -s /bin/bash -u 1000 io -G io

USER io

RUN mix local.rebar --force &&  mix local.hex --force
