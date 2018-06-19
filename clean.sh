#!/bin/bash

readonly OSes=(centos-6 centos-7 ubuntu-12 ubuntu-14)

for os in ${OSes[*]}
do
  image=irods-clients-build:4.1.9-"$os"

  if [ -n $(docker images --quiet "$image") ]
  then
    docker run --interactive --rm \
               --name=netcdf-builder \
               --user=$(id -u):$(id -g) \
               --volume=$(pwd)/irods:/src/4.1.9 \
               --volume=$(pwd)/packages:/packages \
               --volume=$(pwd)/scripts/clean-packages.sh:/clean-packages.sh \
               "$image" /clean-packages.sh "$os"
  fi
done
