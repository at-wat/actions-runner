FROM ubuntu:20.04

RUN apt-get update -qq \
  && apt-get install -y \
    apt-transport-https \
    bash \
    curl \
    wget \
    sudo

RUN wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && rm packages-microsoft-prod.deb \
  && apt-get update -qq \
  && apt-get install -y apt-transport-https \
  && apt-get update -qq \
  && apt-get install -y aspnetcore-runtime-5.0

RUN useradd -U -G sudo,root runner \
  && echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN mkdir -p /opt/actions-runner \
  && chown runner:runner /opt/actions-runner \
  && mkdir -p /home/runner \
  && chown runner:runner /home/runner
WORKDIR /opt/actions-runner

ENV DEB_REPOSITORY_BASE_URL=http://archive.ubuntu.com/ubuntu/
SHELL ["/bin/bash", "-c"]
COPY scripts/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

USER runner
ENV USER=runner

ARG RUNNER_VERSION=v2.276.1
RUN wget https://github.com/actions/runner/releases/download/${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION:1}.tar.gz -O runner.tar.gz \
  && tar xzf ./runner.tar.gz \
  && rm ./runner.tar.gz
