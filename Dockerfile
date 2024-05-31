ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

ARG UBUNTU_VERSION

RUN apt-get update -qq \
  && apt-get install -y \
    awscli \
    apt-transport-https \
    bash \
    curl \
    wget \
    sudo \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://packages.microsoft.com/config/ubuntu/${UBUNTU_VERSION}/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && rm packages-microsoft-prod.deb \
  && apt-get update -qq \
  && apt-get install -y apt-transport-https \
  && apt-get update -qq \
  && case ${UBUNTU_VERSION} in \
      20.04) ASPNETCORE_VERSION=5.0;; \
      *) ASPNETCORE_VERSION=6.0;; \
    esac \
  && apt-get install -y aspnetcore-runtime-${ASPNETCORE_VERSION} \
  && rm -rf /var/lib/apt/lists/*

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

ARG RUNNER_VERSION=v2.317.0
RUN wget https://github.com/actions/runner/releases/download/${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION:1}.tar.gz -O runner.tar.gz \
  && tar xzf ./runner.tar.gz \
  && rm ./runner.tar.gz
