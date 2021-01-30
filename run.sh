#!/bin/bash

docker run -it --rm \
  -v $(pwd)/.runner:/opt/actions-runner/.runner \
  actions-runner ./run.sh $@
