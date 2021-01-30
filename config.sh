#!/bin/bash

touch .runner
docker run -it \
  --name actions-runner-config \
  actions-runner ./config.sh $@
docker cp actions-runner-config:/opt/actions-runner/.runner ./
docker container rm actions-runner-config
