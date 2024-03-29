#!/bin/bash

touch .runner
docker run -it \
  --name actions-runner-config \
  ghcr.io/at-wat/actions-runner ./config.sh --disableupdate $@
docker cp actions-runner-config:/opt/actions-runner/.runner ./
docker cp actions-runner-config:/opt/actions-runner/.credentials ./
docker cp actions-runner-config:/opt/actions-runner/.credentials_rsaparams ./
docker cp actions-runner-config:/opt/actions-runner/.env ./
docker cp actions-runner-config:/opt/actions-runner/.path ./
docker container rm actions-runner-config
