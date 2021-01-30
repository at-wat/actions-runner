#!/bin/bash

docker run -it --rm \
  ${DOCKER_OPTS:-} \
  -v $(pwd)/.runner:/opt/actions-runner/.runner \
  actions-runner ./run.sh $@
