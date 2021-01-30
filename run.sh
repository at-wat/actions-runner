#!/bin/bash

docker run --rm \
  ${DOCKER_OPTS:-} \
  -v $(pwd)/.runner:/opt/actions-runner/.runner \
  -v $(pwd)/.credentials:/opt/actions-runner/.credentials \
  -v $(pwd)/.credentials_rsaparams:/opt/actions-runner/.credentials_rsaparams \
  -v $(pwd)/.env:/opt/actions-runner/.env \
  -v $(pwd)/.path:/opt/actions-runner/.path \
  actions-runner ./run.sh $@
