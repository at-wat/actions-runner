FROM alpine:3.13

RUN apk add --no-cache \
  icu-libs \
  krb5-libs \
  libgcc \
  libintl \
  libssl1.1 \
  libstdc++ \
  zlib

RUN wget https://download.visualstudio.microsoft.com/download/pr/cd4d5d32-f493-411e-9e04-ecaae0a372f0/252cc794c641b6bbdae0faeeb6e78152/aspnetcore-runtime-5.0.2-linux-musl-arm64.tar.gz -O /tmp/core.tar.gz \
  && mkdir -p /usr/dotnet \
  && tar xzf /tmp/core.tar.gz -C /usr/dotnet \
  && rm /tmp/core.tar.gz

ENV PATH=/usr/dotnet:${PATH}

RUN apk add --no-cache \
  bash \
  coreutils \
  sudo

RUN addgroup -g 1000 runner \
  && adduser -S runner -s /bin/bash -D -g runner -G wheel -u 1000 \
  && passwd -u runner \
  && echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN mkdir -p /opt/actions-runner \
  && chown runner:runner /opt/actions-runner
WORKDIR /opt/actions-runner

USER runner

ARG RUNNER_VERSION=2.276.1
RUN wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -O runner.tar.gz \
  && tar xzf ./runner.tar.gz \
  && rm ./runner.tar.gz
