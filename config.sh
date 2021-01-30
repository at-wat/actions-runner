#!/bin/bash

touch .runner
docker run -it --rm \
  -v $(pwd)/.runner:/opt/actions-runner/.runner \
  actions-runner ./config.sh $@
