#!/bin/bash

readonly OS="$1"

rm --force --recursive /packages/"$OS"

for ver in 4.1.9 4.1.9-cv
do
  /src/"$ver"/packaging/build.sh clean
  rm --force /src/"$ver"/icommands.tgz
done
