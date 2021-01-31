#!/bin/bash

required_files="
  .runner
  .credentials
  .credentials_rsaparams
  .env
  .path
"

opts=
fail=false
for file in ${required_files}
do
  if [ ! -f ${file} ]
  then
    echo "${file} not found" >&2
    fail=true
  fi
  opts="${opts} -v $(pwd)/${file}:/opt/actions-runner/${file}"
done

if $fail
then
  echo $opts
  exit 1
fi

exec docker run --rm \
  ${DOCKER_OPTS:-} \
  ${opts} \
  ghcr.io/at-wat/actions-runner ./run.sh $@
