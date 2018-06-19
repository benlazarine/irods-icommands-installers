#!/bin/bash

readonly OSes=(centos-6 centos-7 ubuntu-12 ubuntu-14)
readonly Ver=4.1.10

for os in ${OSes[*]}
do
  image=irods-clients-build:"$Ver"-"$os"

  if [ -n $(docker images --quiet "$image") ]
  then
    docker run --interactive --rm \
               --name=netcdf-builder \
               --user=$(id -u):$(id -g) \
               --volume=$(pwd)/irods:/src/"$Ver" \
               --volume=$(pwd)/packages:/packages \
               --volume=$(pwd)/scripts/clean-packages.sh:/clean-packages.sh \
               "$image" /clean-packages.sh "$os"
  fi
done
