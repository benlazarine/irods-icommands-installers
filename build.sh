#!/bin/bash

readonly OSes=(centos-6 centos-7 opensuse-13 ubuntu-12 ubuntu-14)

for os in ${OSes[*]}
do
  image=irods-clients-build:4.1.9-"$os"

  docker build --file dockerfiles/Dockerfile."$os" --tag "$image" .

  docker run --interactive --rm \
             --name=clients-builder \
             --user=$(id -u):$(id -g) \
             --volume=$(pwd)/irods:/src/4.1.9 \
             --volume=$(pwd)/cyverse-irods:/src/4.1.9-cv \
             --volume=$(pwd)/packages:/packages \
             --volume=$(pwd)/scripts:/scripts \
             "$image" /scripts/clean-packages.sh "$os"

  docker run --interactive --rm \
             --name=clients-builder \
             --user=$(id -u):$(id -g) \
             --volume=$(pwd)/irods:/src/4.1.9 \
             --volume=$(pwd)/cyverse-irods:/src/4.1.9-cv \
             --volume=$(pwd)/packages:/packages \
             --volume=$(pwd)/scripts:/scripts \
             "$image" /scripts/build-packages.sh "$os"
done
