#!/bin/bash

readonly OSes=(centos-6 centos-7 ubuntu-12 ubuntu-14)
readonly Ver=4.1.10

for os in ${OSes[*]}
do
  image=irods-clients-build:"$Ver"-"$os"

  docker build --file dockerfiles/Dockerfile."$os" --tag "$image" .

  docker run --interactive --rm \
             --name=clients-builder \
             --user=$(id -u):$(id -g) \
             --volume=$(pwd)/irods:/src/"$Ver" \
             --volume=$(pwd)/packages:/packages \
             --volume=$(pwd)/scripts:/scripts \
             "$image" /scripts/clean-packages.sh "$os"

  docker run --interactive --rm \
             --name=clients-builder \
             --user=$(id -u):$(id -g) \
             --volume=$(pwd)/irods:/src/"$Ver" \
             --volume=$(pwd)/packages:/packages \
             --volume=$(pwd)/scripts:/scripts \
             "$image" /scripts/build-packages.sh "$os"
done
