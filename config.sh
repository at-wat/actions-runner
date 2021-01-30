#!/bin/bash

touch .runner
docker run -it \
  --name actions-runner-config \
  actions-runner ./config.sh $@
docker cp actions-runner-config:/opt/actions-runner/.runner ./
docker cp actions-runner-config:/opt/actions-runner/.credentials ./
docker cp actions-runner-config:/opt/actions-runner/.credentials_rsaparams ./
docker cp actions-runner-config:/opt/actions-runner/.env ./
docker cp actions-runner-config:/opt/actions-runner/.path ./
docker container rm actions-runner-config
